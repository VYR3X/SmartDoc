//
//  Coordinator.swift
//  Smart Doc
//
//  Created by 17790204 on 12/04/2020.
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
	var bdate: String? 		// выбранная дата в календаре

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

	func routeBack(from viewController: UIViewController) {
		navigationController?.popViewController(animated: true)
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
//		guard let productsModel = productsModel else { return }
		let viewController = assembly.makeDoctorsViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToMeetingDoctor() {
//		guard let productsModel = productsModel else { return }
		let viewController = assembly.makeTimeTableViewController(coordinator: self)
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
