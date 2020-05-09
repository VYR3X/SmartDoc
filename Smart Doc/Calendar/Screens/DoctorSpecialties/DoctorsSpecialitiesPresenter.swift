//
//  DoctorsSpecialitiesPresenter.swift
//  Smart Doc
//
//  Created by 17790204 on 30/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit
/// Интерфейс взаимодействия с презентером экрана TransfersToAnotherPerson.
protocol DoctorsSpecialitiesPresentable {}

/// Презентер флоу переводы: другому человеку
final class DoctorsSpecialitiesPresenter: DoctorsSpecialitiesPresentable {

	/// Вью контроллер разводного экрана переводы: другому человеку
	weak var viewController: UIViewController?

	private let interactor: DoctorSpecialitiesInteractable
	private let coordinator: FlowCoordinating & FlowRouting

	init(interactor: DoctorSpecialitiesInteractable,
		 coordinator: FlowCoordinating & FlowRouting) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - CalendarPresentableListener

extension DoctorsSpecialitiesPresenter: DoctorSpecialitiesListener {

	func didOpenCalendar(Resource_ID: String) {
		coordinator.routeToCalendar(resourceID: Resource_ID)
	}

	func didLoad(_ viewController: UIViewController) {}

	func didPressBack(_ viewController: UIViewController) {
		coordinator.routeBack(from: viewController)
	}
}
