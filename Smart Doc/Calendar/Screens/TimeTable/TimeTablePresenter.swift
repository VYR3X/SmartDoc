//
//  TimeTablePresenter.swift
//  Smart Doc
//
//  Created by 17790204 on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с презентером экрана TimeTable.
protocol TimeTablePresentable {}

/// Презентер флоу переводы: другому человеку
final class TimeTablePresenter: TimeTablePresentable {

	/// Вью контроллер разводного экрана переводы: другому человеку
	weak var viewController: UIViewController?

	private let interactor: TimeTableInteractable
	private let coordinator: FlowCoordinating & FlowRouting

	init(interactor: TimeTableInteractable,
		 coordinator: FlowCoordinating & FlowRouting) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - CalendarPresentableListener

extension TimeTablePresenter: TimeTablePresentableListener {

	func createAppointment() {
		interactor.createAppointment()
	}


	func didLoad(_ viewController: UIViewController) {}

	func didPressBack(_ viewController: UIViewController) {}

}

