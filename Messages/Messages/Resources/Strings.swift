//
//  Strings.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//

//import Foundation

enum Strings: String {
    case cancel = "Отмена"
    case message = "Cообщение"
    case notAvailable = "Информация недоступна"
    case checkInternetConnection = "Приложение 'Messages' не подключено к интернету.\nПроверьте интернет соединение."
    case settings = "Настройки"
    case errorTitle = "Oшибка"
    case testCase = "Тестовое задание"
    case retry =  "Повторить"
    case delete = "Удалить"
    case myAVA = "https://upload.wikimedia.org/wikipedia/commons/f/f5/Pic-vk-allaboutme-ava-2.jpg"
    case serverAVA = "https://www.perunica.ru/uploads/posts/2019-03/1552932077_1.jpg"
}

enum Fonts: String {
    case montserratBold = "Montserrat-Bold"
    case montserratSemiBold = "Montserrat-SemiBold"
    case montserratMedium = "Montserrat-Medium"
}

enum CoreDataEntity: String {
    case name = "Messages"
}

enum CellsID: String {
    case outgoing = "outgoingCell"
    case incoming = "cell"
}

enum Colors: String {
    case appBlack = "appBlack"
    case appDarkBlue = "appDarkBlue"
    case appMediumBlack = "appMediumBlack"
    case appMediumBlue = "appMediumBlue"
    case appOutgoingMessage = "appOutgoingMessage"
    case appIncomeMessage = "appIncomeMessage"
}
