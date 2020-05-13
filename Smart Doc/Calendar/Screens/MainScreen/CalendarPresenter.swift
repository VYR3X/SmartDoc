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

	var viewModel: SlotViewModel?

	init(interactor: CalendarInteractable,
		 coordinator: FlowCoordinating & FlowRouting) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - CalendarPresentableListener

extension CalendarPresenter: CalendarPresentableListener {

	func loadData() {}

	func personSelectDate(date: String, resourceID: String) {

		interactor.getDoctorTickets(selectdate: date, resourceID: resourceID) { (result) in
			switch result {
			case .success(let slots):
				print("\nУспешно выполнен запрос на получение талонов :\n\(slots)")
				self.viewModel = SlotViewModel(model: slots)
				//print("\nПолучает вью модель:\n\(self.viewModel)")
				self.openNextView(slots: slots)

			case .failure(let error):
				print("error: \n \(error)")
			}
		}
	}

	func openNextView(slots: TicketModel) {
		coordinator.setTicketModel(model: slots)
	}

	func didPressDoctors() {
		coordinator.routeToDoctors()
	}

	func didLoad(_ viewController: UIViewController) {

		//convertModelToViewModel()
//		let cards = interactor.getCardsModel()
//		let cardsViewModel = cards.map { CardViewModel(model: $0) }
//		viewController.setCards(viewModel: cardsViewModel)
	}

	func didPressBack(_ viewController: UIViewController) {
		coordinator.routeBack(from: viewController)
	}
}
