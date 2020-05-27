//
//  UserProfilePresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана UserProfile во флоу hj.
protocol UserProfilePresentable {

}

final class UserProfilePresenter: UserProfilePresentable {

    weak var viewController: UserProfileViewControllable?

    private let interactor: UserProfileInteractable
    private let coordinator: FlowCoordinating & FlowRouting

    init(
        interactor: UserProfileInteractable,
        coordinator: FlowCoordinating & FlowRouting
    ) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: UserProfilePresentable

}

// MARK: - UserProfilePresentableListener

extension UserProfilePresenter: UserProfilePresentableListener {

	func openDoctorsSpecialities() {
		coordinator.routeToSpecialitiesList()
	}

	func didLoad(_ viewController: UserProfileViewControllable) {}
}
