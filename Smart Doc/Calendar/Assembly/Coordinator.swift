//
//  Coordinator.swift
//  Smart Doc
//
//  Created by 17790204 on 12/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit

/// Координатор переводов
/// Реализует композицию двух протоколов – TransfersFlowCoordinating & TransfersFlowRouting
final class Coordinator {

	private let assembly: ReseptionFlowAssembly
	private weak var navigationController: UINavigationController?
	private weak var rootViewController: UIViewController?
//	private var productsModel: ProductsModel?

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

// MARK: - TransfersFlowRouting

extension Coordinator: FlowRouting {

	func routeBack(from viewController: UIViewController) {
		navigationController?.popViewController(animated: true)
	}

	func routeToSpecialities() {
		let viewController = assembly.makeSpecialitiesViewController(coordinator: self)
		navigationController?.pushViewController(viewController, animated: true)
	}

	func routeToCalendar() {
//		guard let productsModel = productsModel else { return }
		let viewController = assembly.makeMainViewController(coordinator: self)
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

// MARK: - TransfersFlowCoordinating

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
