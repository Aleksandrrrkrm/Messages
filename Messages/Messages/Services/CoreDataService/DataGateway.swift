//
//  DataGateway.swift
//  Messages
//
//  Created by Александр Головин on 01.06.2023.
//

import CoreData

protocol CoreDataGateway: AnyObject {
    
    func getData(sortDescriptors: [NSSortDescriptor]?) -> [MessageType]?
    
    func deleteAllData()
    
    func saveData(_ data: OutgoingMessageModel, completion: (() -> ())?)
    
    func saveContext()
}

class CoreDataGatewayImp: CoreDataGateway {
    
    fileprivate let coreDataStack: CoredataStack
    
    init(coreDataStack: CoredataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func getData(sortDescriptors: [NSSortDescriptor]?) -> [MessageType]? {
        let fetchRequest: NSFetchRequest<Messages> = Messages.fetchRequest()
        if let sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            var dataModel: [MessageType] = []
            let data = try coreDataStack.managedContext.fetch(fetchRequest)
            data.forEach {
                dataModel.append(MessageType.outgoing($0.text ?? "",
                                                      "https://upload.wikimedia.org/wikipedia/commons/f/f5/Pic-vk-allaboutme-ava-2.jpg",
                                                      $0.date ?? Date()))
            }
            return dataModel
        } catch let error {
#if DEBUG
            print("ошибка getData \(error.localizedDescription)")
#endif
            return nil
        }
    }
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataEntity.name.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            try coreDataStack.managedContext.execute(deleteRequest)
#if DEBUG
            print("удалено")
#endif
            
        } catch let error {
#if DEBUG
            print("ошибка удаления \(error.localizedDescription)")
#endif
        }
    }
    
    func saveData(_ data: OutgoingMessageModel, completion: (() -> ())?) {
        coreDataStack.backgroundContext.perform { [weak self] in
            guard let context = self?.coreDataStack.backgroundContext else {
                return
            }
                
                    let model = Messages(context: context)
            model.text = data.text
            model.date = data.date
                
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    self?.saveContext()
                    completion?()
                }
            } catch let error {
#if DEBUG
                print("ошибка сохранения \(error.localizedDescription)")
#endif
            }
        }
    }
    
    func saveContext() {
        coreDataStack.saveContext()
    }
}
