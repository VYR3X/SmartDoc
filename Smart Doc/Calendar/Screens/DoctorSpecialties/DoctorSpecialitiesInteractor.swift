//
//  DoctorSpecialitiesInteractor.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка категорий специалистов
protocol DoctorSpecialitiesInteractable {

	func getRequest(polyclicID: String?, completion: @escaping (Result<SpecialitiesModel, Error>) -> Void)
}

/// Интерактор списка специальностей врачей
class DoctorSpecialitiesInteractor: DoctorSpecialitiesInteractable {

	/// Сервис для работы с дип линками
	private let specialitiesService: DoctorSpesialitiesServiceProtocol

	/// Конструктор интерактора экрана доп информации по поликлиникам
	/// - Parameter polyclinicService: серви для поликлиник
	init(specialitiesService: DoctorSpesialitiesServiceProtocol) {
		self.specialitiesService = specialitiesService
	}

	func getRequest(polyclicID: String?, completion: @escaping (Result<SpecialitiesModel, Error>) -> Void) {

		specialitiesService.getRequest(polyclinicId: polyclicID) { (result) in
			completion(result)
		}
	}
}
