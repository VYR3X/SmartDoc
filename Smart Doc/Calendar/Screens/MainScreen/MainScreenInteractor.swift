//
//  MainScreenasdfInteractor.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
import Foundation
/// Интерфейс взаимодействия с интерактором экрана MainScreen.
//protocol MainScreenInteractable {
//
//}
//
//final class MainScreenInteractor: MainScreenInteractable {
//
//    init() {}
//
//    // MARK: MainScreenInteractable
//
//}


/// Интерфейс взаимодействия с интерактором экрана списка категорий специалистов
protocol MainScreenInteractable {

	func getPolyclicModel(completion: @escaping (Result<PolyclinicModel, Error>) -> Void)
}

/// Интерактор списка специальностей врачей
final class MainScreenInteractor: MainScreenInteractable {

	/// Сервис для работы с дип линками
	private let polyclinicService: PolyclinicServiceProtocol

	/// Конструктор интерактора экрана доп информации по поликлиникам
	/// - Parameter polyclinicService: серви для поликлиник
	init(polyclinicService: PolyclinicServiceProtocol) {
		self.polyclinicService = polyclinicService
	}

	func getPolyclicModel(completion: @escaping (Result<PolyclinicModel, Error>) -> Void) {
		polyclinicService.getRequest(completion: { result in
			switch result {
			case .success(let model):
				completion(.success(model))
			case .failure(let error):
				print("error: \n \(error)")
				completion(.failure(error))
			}
		})
	}
}
