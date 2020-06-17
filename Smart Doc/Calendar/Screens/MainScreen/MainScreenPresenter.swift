//
//  MainScreenasdfPresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

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

	func didLoadDoctorName() {
		// бэк возвращает одну фамилию так что оставим мок
	}

	func didTapOnPoliclynic(id: String, name: String) {
		coordinator.routeToSpecialitiesList(polyclinicID: id, name: name)
	}

	func didTapDoctorsPhoto() {
		coordinator.routeToSpecialitiesList(polyclinicID: nil, name: nil)
	}

	func didTapSpecialitiesCell(resourceID: String) {
		coordinator.routeToCalendar(resourceID: resourceID, specialization: "специалист")
	}

	func openListOfDoctors() {
		coordinator.routeToDoctors()
	}

	func didLoad(_ viewController: MainScreenViewControllable) {

		interactor.getPolyclicModel(completion: {result in
			switch result {
			case .success(let model):
				DispatchQueue.main.async {
					let vm = PolyclinicsViewModel(model: model)
					viewController.bind(polyclinics: vm.organizations, polyclinicsId: vm.organizatiosId)
				}
			case .failure(let error):
				print("error: \n \(error)")
			}
		})

	}

	func getPolyclinicList(completion: @escaping (Result<PolyclinicsViewModel, Error>) -> Void) {

		interactor.getPolyclicModel(completion: {result in
			switch result {
			case .success(let model):
				DispatchQueue.main.async {
					let vm = PolyclinicsViewModel(model: model)
					completion(.success(vm))
				}
			case .failure(let error):
				print("error: \n \(error)")
				completion(.failure(error))
			}
		})
	}

}
