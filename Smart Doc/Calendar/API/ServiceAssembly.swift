//
//  ServiceAssembly.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Сборщик сервисов
class ServiceAssembly {

	//// Создает сервис для работы с поликлиникой.
	func makePolyclinicService() -> PolyclinicServiceProtocol {
		return PolyclinicService()
	}

	/// Сервис для получения специализации врачей
	func makeDoctorSpesialitiesService() -> DoctorSpesialitiesServiceProtocol {
		return DoctorSpesialitiesService()
	}

	/// Сервис для получения ФИО врачей
	func makeDoctorsService() -> DoctorsServiceProtocol {
		return DoctorsService()
	}

	/// Сервис для получения истории записей пользователя
	func makeOperationHistoryService() -> OperationHistoryServiceProtocol {
		return OperationHistoryService()
	}

	/// Сервис для получения талонов к врачу
	func makeTimeTableService() -> TimeTableServiceProtocol {
		return TimeTableService()
	}
}
