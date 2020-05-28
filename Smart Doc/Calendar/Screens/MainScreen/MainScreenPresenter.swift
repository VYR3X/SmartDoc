//
//  MainScreenasdfPresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана MainScreen.
protocol MainScreenPresentable {}

final class MainScreenPresenter: MainScreenPresentable {

    weak var viewController: MainScreenViewControllable?

    private let interactor: MainScreenInteractable
    private let coordinator: FlowCoordinating & FlowRouting

	init(interactor: MainScreenInteractable,
		 coordinator: FlowCoordinating & FlowRouting) {
		self.interactor = interactor
		self.coordinator = coordinator
	}

    // MARK: MainScreenasdfPresentable

}

// MARK: - MainScreenPresentableListener

extension MainScreenPresenter: MainScreenPresentableListener {

	func didTapDoctorsPhoto() {
		coordinator.routeToSpecialitiesList()
	}

	func didTapSpecialitiesCell(resourceID: String) {
		coordinator.routeToCalendar(resourceID: resourceID)
	}

	func openListOfDoctors() {
		coordinator.routeToDoctors()
	}

	func didLoad(_ viewController: MainScreenViewControllable) {}

}
