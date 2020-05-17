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
	private weak var rootViewController: UIViewController?

	var resource_ID: String? // id специальности врача ( терапевт, хирург, стоматолог )
	var slotModel: TicketModel?

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

	func setTicketModel(model: TicketModel) {
		slotModel = model
	}

	func routeBack(from viewController: UIViewController) {
		navigationController?.popViewController(animated: true)
	}

	func routeToPolyclinics() {
		let viewController = assembly.makePolyclinicsViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToUserProfile() {
		let viewController = assembly.makeProfileViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToSpecialities() {
		let viewController = assembly.makeSpecialitiesViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToCalendar(resourceID: String) {
		resource_ID = resourceID
		let viewController = assembly.makeMainViewController(coordinator: self, resourseID: resourceID)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToDoctors() {
//		guard let doctors = doctors else { return }
		let viewController = assembly.makeDoctorsViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToMeetingDoctor() {

		guard let slotModel = slotModel else { return }
		let viewController = assembly.makeTimeTableViewController(coordinator: self, slotsModel: slotModel)
		navigationController?.pushViewController(viewController, animated: true)
	}
}

// MARK: - FlowCoordinating

extension Coordinator: FlowCoordinating {

	func startFlow() {
//		rootViewController = navigationController?.topViewController
//		self.productsModel = productsModel
//		let mainViewController = assembly.makePaymentsAndTransfersViewController(productsModel: productsModel,
//																				 coordinator: self)
//		navigationController?.pushViewController(mainViewController, animated: true)
	}

	func finishFlow() {
//		guard let rootViewController = rootViewController else { return }
//		navigationController?.popToViewController(rootViewController, animated: true)
	}
}
