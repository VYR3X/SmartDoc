//
//  OperationHistoryPresenter.swift
//  Smart Doc
//
//  Created by 17790204 on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

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

	func didLoad(_ viewController: OperationHistoryViewControllable) {}
}
