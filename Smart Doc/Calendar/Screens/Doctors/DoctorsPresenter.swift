//
//  DoctorsPresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit
/// Интерфейс взаимодействия с презентером экрана TransfersToAnotherPerson.
protocol DoctorsPresentable {}

/// Презентер флоу переводы: другому человеку
final class DoctorsPresenter: DoctorsPresentable {

	/// Вью контроллер разводного экрана переводы: другому человеку
	weak var viewController: UIViewController?

	private let interactor: DoctorsInteractable
	private let coordinator: FlowCoordinating & FlowRouting

	init(interactor: DoctorsInteractable,
		 coordinator: FlowCoordinating & FlowRouting) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - CalendarPresentableListener

extension DoctorsPresenter: DoctorsPresentableListener {
	
	func didLoad(_ viewController: UIViewController) {}

	func didPressBack(_ viewController: UIViewController) {
		coordinator.routeBack(from: viewController)
	}

	func didPressReadyToMeetDoctor() {
		coordinator.routeToMeetingDoctor()
	}
}

