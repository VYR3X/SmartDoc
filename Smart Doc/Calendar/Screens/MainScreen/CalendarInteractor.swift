//
//  CalendarInteractor.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана Calendar
protocol CalendarInteractable {

	/// Метод для получения талонов на прием к врачу по выбранный дате из календаря
	/// - Parameters:
	///   - selectdate: Выбранная пользователем дата в календаре
	///   - resourceID: Выбранная специализация врача (хирург, терапевт, стоматолог)
	func getDoctorTickets(selectdate: String, resourceID: String)
}

/// Интерактор экрана: Календарь
final class CalendarInteractor: CalendarInteractable {

	func getDoctorTickets(selectdate: String, resourceID: String) {

		let resource = "SLOT"
		let method = "SEARCH"
		let params = "{RESOURCE_ID:\"\(resourceID)\",BDATE:\"\(selectdate)\",EDATE:\"\(selectdate)\"}"

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

		let session = URLSession.shared

		session.dataTask(with: url!) { (data , responce, error) in

			if let responce = responce {
				print(responce)
			}

			guard let data = data else { return }

			guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
				print("could not convert data to UTF-8 format")
				return
			}

			do {
				let interinData = try JSONSerialization.jsonObject(with: utf8Data, options: .mutableContainers)
				print(interinData)
			}
			catch {
				print(error)
			}
		}.resume()

	}
}
