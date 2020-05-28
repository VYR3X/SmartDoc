//
//  FlowRouting.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 12/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit

/// Протокол роутинга между экранами
protocol FlowRouting {

	/// Вернуться назад
	///
	/// - Parameter from: с вью контроллера
	func routeBack(from viewController: UIViewController)

	/// Перекинуть на главный экран
	func routeToMainScreen()

	/// Перекинуть на список со специальностями врачей
	func routeToSpecialitiesList()

	/// Перекинуть на экран календарь
	func routeToCalendar(resourceID: String)

	/// Перекинуть на экран c именами врачей
	func routeToDoctors()

	/// Перекинуть на экран запись на прием к врачу
	func routeToMeetingDoctor()

	/// Перекинуть на экран: профиль пользователя
	func routeToUserProfile()

	//var model: SlotModel { get set }

	func setTicketModel(model: TicketModel)

}

