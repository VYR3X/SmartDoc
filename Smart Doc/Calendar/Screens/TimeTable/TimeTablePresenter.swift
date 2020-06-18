//
//  TimeTablePresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
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

	func didTapContinue(time: String, date: String) {
		coordinator.finishFlow(time: time, date: date)
	}

	func didTapRepeat() {
		coordinator.repeateReseption()
	}

	func createAppointment(slotID: String,
						   firstName: String,
						   birthday: String,
						   phoneNumber: String,
						   email: String,
						   polis: String) {

		interactor.createAppointment(slotId: slotID,
									 firstName: firstName,
									 birthday: birthday,
									 phoneNumber: phoneNumber,
									 email: email,
									 polis: polis) { (result) in
										switch result {
										case .success(let responce):
											print("\nЗапись прошла успешно:\n\(responce)")
										case .failure(let error):
											print("\nПроизошла ошибка при созданни записи:\n\(error)")
										}
		}


	}

	func didLoad(_ viewController: UIViewController) {}

	func didPressBack(_ viewController: UIViewController) {}

}

