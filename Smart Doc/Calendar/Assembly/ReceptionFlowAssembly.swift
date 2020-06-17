//
//  ReseptionFlowAssembly.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit

/// Сборщик флоу запись на прием к врачу
final class ReseptionFlowAssembly {

	//private weak var coordinator: Coordinator?
	private var orderID: String?
	private let services = ServiceAssembly()

	//	init(services: ServiceAssembly) {
	//		self.services = services
	//	}

	init() {}

	/// Метод для сборки главного экрана
	func makeMainViewController(coordinator: Coordinator) -> UIViewController {
		let polyclicService = services.makePolyclinicService()
		let interactor = MainScreenInteractor(polyclinicService: polyclicService)
		let presenter = MainScreenPresenter(interactor: interactor,
													 coordinator: coordinator)
		let viewController = MainScreenViewController(listener: presenter)
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана Поликлиники
	func makePolyclinicsViewController(coordinator: Coordinator) -> UIViewController {
		//let polyclicService = services.makePolyclinicService()
		let interactor = PolyclinicsInteractor()
		let presenter = PolyclinicsPresenter(interactor: interactor,
													 coordinator: coordinator)
		let viewController = PolyclinicsViewController(listener: presenter)
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана Профиль пользователя
	func makeProfileViewController(coordinator: Coordinator) -> UIViewController {
		let interactor = UserProfileInteractor()
		let presenter = UserProfilePresenter(interactor: interactor,
													 coordinator: coordinator)
		let viewController = UserProfileViewController(listener: presenter)
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана со списком специальностей врачей
	func makeSpecialitiesViewController(coordinator: Coordinator, polyclinicID: String?, polyclinicName: String?) -> UIViewController {
		let specialitiesService = services.makeDoctorSpesialitiesService()
		let interactor = DoctorSpecialitiesInteractor(specialitiesService: specialitiesService)
		let presenter = DoctorsSpecialitiesPresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = DoctorSpecialitiesViewController(listener: presenter)
		viewController.polyclinicID = polyclinicID ?? "7F7DA9355EAAF96FE0530100007F0F8B"
		viewController.polyclinicName = polyclinicName ?? "Первая городская"
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана со списком Докторов
	func makeDoctorsViewController(coordinator: Coordinator) -> UIViewController {
		let doctorsService = services.makeDoctorsService()
		let interactor = DoctorsInteractor(doctorsService: doctorsService)
		let presenter = DoctorsPresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = DoctorsViewController(listener: presenter)
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана с каленадарем
	func makeCalendarViewController(coordinator: Coordinator, resourseID: String) -> UIViewController {
		let interactor = CalendarInteractor()
		let presenter = CalendarPresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = CalendarViewController(listener: presenter)
		viewController.resourseID = resourseID
		presenter.viewController = viewController
		return viewController
	}

	/// Метод для сборки экрана со списком свободного времени для записи
	func makeTimeTableViewController(coordinator: Coordinator, slotsModel: SlotViewModel) -> UIViewController {
		let timeTableService = services.makeTimeTableService()
		let interactor = TimeTableInteractor(timeTableService: timeTableService)
		let presenter = TimeTablePresenter(interactor: interactor,
															   coordinator: coordinator)
		let viewController = TimeTableViewController(listener: presenter)
		presenter.viewController = viewController
		viewController.datasourse = slotsModel
		return viewController
	}

	/// Метод для сборки экрана История записи к врачу
	func makeOperationHistoryViewController(coordinator: Coordinator) -> UIViewController {
		let operationHistoryService = services.makeOperationHistoryService()
		let interactor = OperationHistoryInteractor(operationHistoryService: operationHistoryService)
		let presenter = OperationHistoryPresenter(interactor: interactor,
													 coordinator: coordinator)
		let viewController = OperationHistoryViewController(listener: presenter)
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
