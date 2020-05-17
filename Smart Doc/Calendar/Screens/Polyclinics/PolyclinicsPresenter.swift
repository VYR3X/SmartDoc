//
//  PolyclinicsPresenter.swift
//  Smart Doc
//
//  Created by 17790204 on 10/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана Polyclinics.
protocol PolyclinicsPresentable {

}

final class PolyclinicsPresenter: PolyclinicsPresentable {

    weak var viewController: PolyclinicsViewControllable?

    private let interactor: PolyclinicsInteractable
    private let coordinator: FlowCoordinating & FlowRouting

    init(
        interactor: PolyclinicsInteractable,
        coordinator: FlowCoordinating & FlowRouting
    ) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: PolyclinicsdfPresentable

}

// MARK: - PolyclinicsPresentableListener

extension PolyclinicsPresenter: PolyclinicsPresentableListener {

	func openNextViewController() {
		coordinator.routeToUserProfile()
	}

	func didLoad(_ viewController: PolyclinicsViewControllable) {}
}
