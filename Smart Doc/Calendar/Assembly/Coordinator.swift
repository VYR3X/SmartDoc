//
//  Coordinator.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 12/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit

/// Координатор
/// Реализует композицию двух протоколов – FlowCoordinating & FlowRouting
final class Coordinator {

	private let assembly: ReseptionFlowAssembly
	private weak var navigationController: UINavigationController?
	private var receptionNavigationController: ReceptionNavigationController? // нав контроллер основгоно флоу записи
	private weak var rootViewController: UIViewController?

	/// id специальности врача ( терапевт, хирург, стоматолог )
	var resource_ID: String?
	var slotModel: SlotViewModel?
	/// выбрали специалиста на экране список врачей и не закончили запись
	var currentSpecialist: String?
	/// массив с выбранными специализациями врачей для формирования талонов
	var specializationNames: [String] = []
	/// массив c временем для талонов на которые записался пациент
	var selectTime: [String] = []
	/// выбранная поликлиника для записи
	var currentPolyclinic: String?
	/// массив поликлиник
	var polyclinicNames: [String] = []

	/// Конструктор
	///
	/// - Parameters:
	///   - assembly: сборщик флоу
	///   - navigationController: навигация флоу
	init(assembly: ReseptionFlowAssembly, navigationController: UINavigationController?) {
		self.assembly = assembly
		self.navigationController = navigationController
	}
}

// MARK: - FlowRouting

extension Coordinator: FlowRouting {

	func setTicketModel(model: SlotViewModel) {
		slotModel = model
	}

	func routeBack(from viewController: UIViewController) {
		navigationController?.popViewController(animated: true)
	}

	func routeToMainScreen() {
		let viewController = assembly.makeMainViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
		rootViewController = viewController
	}

	func routeToPolyclinics() {
		let viewController = assembly.makePolyclinicsViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToUserProfile() {
		let viewController = assembly.makeProfileViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToSpecialitiesList(polyclinicID: String?, name: String?) {
		progressView.setProgress(0.2, animated: false)
		currentPolyclinic = name
		let viewController = assembly.makeSpecialitiesViewController(coordinator: self,
																	 polyclinicID: polyclinicID,
																	 polyclinicName: name)
//		receptionNavigationController = ReceptionNavigationController(rootViewController: viewController)
	//	guard let receptionNavigationController = receptionNavigationController else { return }
		navigationController?.pushViewController(viewController, animated: true)
		//receptionNavigationController.pushViewController(viewController, animated: true)
	}

	func routeToCalendar(resourceID: String,  specialization: String) {
		progressView.setProgress(0.4, animated: false)
		resource_ID = resourceID
		currentSpecialist = specialization
		//specializationNames.append(specialization)
		let viewController = assembly.makeCalendarViewController(coordinator: self, resourseID: resourceID)
		//receptionNavigationController?.navigationBar.backgroundColor = .orange
		//receptionNavigationController!.pushViewController(viewController, animated: true)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToDoctors() {
//		guard let doctors = doctors else { return }
		progressView.setProgress(0.8, animated: false)
		let viewController = assembly.makeDoctorsViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToMeetingDoctor() {
		progressView.setProgress(1.0, animated: false)
		guard let slotModel = slotModel else { return }
		let viewController = assembly.makeTimeTableViewController(coordinator: self, slotsModel: slotModel)
		navigationController?.pushViewController(viewController, animated: true)
	}
}

// MARK: - FlowCoordinating

extension Coordinator: FlowCoordinating {

	func createNavigationContoller(vc: UIViewController) -> UINavigationController {
		navigationController?.pushViewController(vc, animated: true)
		return navigationController!
	}

	func startFlow() {
//		rootViewController = navigationController?.topViewController
//		self.productsModel = productsModel
		let mainViewController = assembly.makeSpecialitiesViewController(coordinator: self, polyclinicID: nil, polyclinicName: nil)
//																				 coordinator: self)
		navigationController?.pushViewController(mainViewController, animated: true)
	}

	func finishFlow(time: String, date: String) {
		let specialist = String(currentSpecialist!.dropLast(1))
		specializationNames.append(specialist)
		polyclinicNames.append(currentPolyclinic!)
		let selectDate = date + "   " + time
		selectTime.append(selectDate)
		dataStoreManager.setTicketToCoreData(dates: selectTime,
											 specialization: specializationNames,
											 polyclinicNames: polyclinicNames)
		print("Записались на такое время: \(selectTime)")
		print("Записались к таким специалистам: \(specializationNames)")
		routeToMainScreen()
	}
}
