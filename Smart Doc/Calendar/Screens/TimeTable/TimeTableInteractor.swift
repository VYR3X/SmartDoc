//
//  TimeTableInteractor.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана TimeTable
protocol TimeTableInteractable {

	/// Создать запись к врачу

	/// Создать запись к врачу
	/// - Parameters:
	///   - slotId: id выбранного талона
	///   - firstName: имя пользователя
	///   - birthday: дата рождения пользователя
	///   - phoneNumber: номер телефона
	///   - email: почта
	///   - polis: номер полиса
	func createAppointment(slotId: String,
						   firstName: String,
						   birthday: String,
						   phoneNumber: String,
						   email: String,
						   polis: String,
						   completion: @escaping (Result<Any, Error>) -> Void)
}

/// Интерактор c расписанием врача
final class TimeTableInteractor: TimeTableInteractable {

	/// Сервис для работы с дип линками
	private let timeTableService: TimeTableServiceProtocol

	/// Конструктор интерактора экрана доп информации по поликлиникам
	/// - Parameter polyclinicService: серви для поликлиник
	init(timeTableService: TimeTableServiceProtocol) {
		self.timeTableService = timeTableService
	}

	func createAppointment(slotId: String,
						   firstName: String,
						   birthday: String,
						   phoneNumber: String,
						   email: String,
						   polis: String,
						   completion: @escaping (Result<Any, Error>) -> Void) {
		timeTableService.createAppointment(slotId: slotId,
										   firstName: firstName,
										   birthday: birthday,
										   phoneNumber: phoneNumber,
										   email: email, polis: polis,
										   completion: { result in
											completion(result)
		})
	}

}
