//
//  OperationHistoryPresenter.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с презентером экрана OperationHistory во флоу asdf.
protocol OperationHistoryPresentable {}

final class OperationHistoryPresenter: OperationHistoryPresentable {

    weak var viewController: OperationHistoryViewControllable?

    private let interactor: OperationHistoryInteractable
    private let coordinator: FlowCoordinating & FlowRouting

    init(
        interactor: OperationHistoryInteractable,
        coordinator: FlowCoordinating & FlowRouting
    ) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: OperationHistoryPresentable

}

// MARK: - OperationHistoryPresentableListener

extension OperationHistoryPresenter: OperationHistoryPresentableListener {

	func didLoad(_ viewController: OperationHistoryViewControllable, resourceID: String) {

		interactor.getHistory(resourceID: resourceID, completion: {productsModelResult in
			switch productsModelResult {
			case .success(let history):
				DispatchQueue.main.async {
					//print("\nПолучили специализацию врачей: \n\(doctorsModel)")
					let vm = OperationHistoryViewModel(model: history)
					self.viewController?.bind(dateTimeLabels: vm.starts,
											  specialitiesNameLabels: vm.doctorSpecislities)
					print("количество записей : \(vm.books.count)\n")
					print("специализации: \(vm.doctorSpecislities)\n")
					print("время приема: \(vm.starts)\n")
				}
			case .failure(let error):
				print("error: \n \(error)")
			}
		})
	}
}
