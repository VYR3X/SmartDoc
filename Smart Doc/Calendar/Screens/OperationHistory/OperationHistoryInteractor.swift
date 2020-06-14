//
//  OperationHistoryInteractor.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана OperationHistory во флоу asdf.
protocol OperationHistoryInteractable {

	func getHistory(resourceID: String, completion: @escaping (Result<OperationHistoryModel, Error>) -> Void)

}

final class OperationHistoryInteractor: OperationHistoryInteractable {

    /// Сервис для работы с дип линками
	private let operationHistoryService: OperationHistoryServiceProtocol

	/// Конструктор интерактора экрана доп информации по поликлиникам
	/// - Parameter polyclinicService: серви для поликлиник
	init(operationHistoryService: OperationHistoryServiceProtocol) {
		self.operationHistoryService = operationHistoryService
	}

	// MARK: OperationHistoryInteractable

	func getHistory(resourceID: String, completion: @escaping (Result<OperationHistoryModel, Error>) -> Void) {
		operationHistoryService.getDoctorTickets(resourceID: resourceID) { (result) in
			completion(result)
		}
	}
}
