//
//  CalendarPresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import UIKit
/// Интерфейс взаимодействия с презентером экрана TransfersToAnotherPerson.
protocol CalendarPresentable {}

/// Презентер флоу переводы: другому человеку
final class CalendarPresenter: CalendarPresentable {

	/// Вью контроллер разводного экрана переводы: другому человеку
	weak var viewController: UIViewController?

	private let interactor: CalendarInteractable
	private let coordinator: FlowCoordinating & FlowRouting

	init(interactor: CalendarInteractable,
		 coordinator: FlowCoordinating & FlowRouting) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - CalendarPresentableListener

extension CalendarPresenter: CalendarPresentableListener {

	func personSelectDate(date: String, resourceID: String) {
		interactor.getDoctorTickets(selectdate: date, resourceID: resourceID)
	}


	func didPressDoctors() {
		coordinator.routeToDoctors()
	}

	func didLoad(_ viewController: UIViewController) {

//		let cards = interactor.getCardsModel()
//		let cardsViewModel = cards.map { CardViewModel(model: $0) }
//		viewController.setCards(viewModel: cardsViewModel)
	}

	func didPressBack(_ viewController: UIViewController) {
		coordinator.routeBack(from: viewController)
	}


}
