//
//  TimeTableInteractor.swift
//  Smart Doc
//
//  Created by 17790204 on 01/03/2020.
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

	func createAppointment(slotId: String,
						   firstName: String,
						   birthday: String,
						   phoneNumber: String,
						   email: String,
						   polis: String,
						   completion: @escaping (Result<Any, Error>) -> Void) {

		print("Post button tapped")

		let resource = "APPOINTMENT"
		let method = "CREATE"
		let params = "{SLOT_ID:\"\(slotId)\",PATIENT_NAME:\"\(firstName)\",PATIENT_LASTNAME:\"\(firstName)\",PATIENT_BIRTHDAY:\"\(birthday)\",PATIENT_PHONE:\"\(phoneNumber)\",PATIENT_EMAIL:\"\(email)\",PATIENT_POLICY:\"\(polis)\"}"

		var url: URL? {
			var components = URLComponents()
			components.scheme = "https"
			components.host =  "services.interin.ru"
			components.path = "/wix.registry_api"
			components.queryItems = [
				URLQueryItem(name: "p_resource", value: resource),
				URLQueryItem(name: "p_method", value: method),
				URLQueryItem(name: "p_params", value: params)
			]
			return components.url
		}

//		let parametrs = ["SLOT_ID": "A47EFFADC5C0715BE0530100007F9634", "PATIENT_NAME": "ДМИТРИЙ", "PATIENT_LASTNAME": "Иванов"]
//
//		print(url)
//
		var request = URLRequest(url: url!)
		request.httpMethod = "POST"
//
//		guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
//
//		request.httpBody = httpBody

		let session = URLSession.shared

		session.dataTask(with: request) { (data , responce, error) in
			if let responce = responce {
				print(responce)
			}

			guard let data = data else { return }

			do {
				let interinData = try JSONSerialization.jsonObject(with: data, options: [])
				//print(interinData)
				completion(.success(interinData))

			} catch let jsonError {
				//print(error)
				completion(.failure(jsonError))
			}
		}.resume()
	}

}
