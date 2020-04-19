//
//  ReseptionFlowAssembly.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit

/// Сборщик флоу отмена оплаты билета
final class ReseptionFlowAssembly {

	//private weak var coordinator: Coordinator?
	private var orderID: String?

	private let services: ServiceAssembly

	//private weak var coordinator: PurchaseFlowCoordinator?

	init(services: ServiceAssembly) {
		self.services = services
	}

	/// Метод для сборки экрана со списком Докторов
	func makeDoctorsViewController(coordinator: Coordinator) -> UIViewController {
		let interactor = DoctorsInteractor()
		let presenter = DoctorsPresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = DoctorsViewController()
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана с каленадарем
	func makeMainViewController(coordinator: Coordinator) -> UIViewController {
		let interactor = CalendarInteractor()
		let presenter = CalendarPresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = CalendarViewController()
		// проблема с init поэтому так :(
		viewController.listener = presenter

		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана со списком свободного времени для записи
	func makeTimeTableViewController(coordinator: Coordinator) -> UIViewController {
		let interactor = TimeTableInteractor()
		let presenter = TimeTablePresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = TimeTableViewController()
		presenter.viewController = viewController
		return viewController
	}

	/// Создать координатор
	///
	/// - Parameter context: контекст навигации
	/// - Returns: координатор
	func makeCoordinator(in context: UINavigationController?) -> Coordinator {
		return Coordinator(assembly: self, navigationController: context)
	}
}
