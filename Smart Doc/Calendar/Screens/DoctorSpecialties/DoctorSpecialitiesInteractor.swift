//
//  DoctorSpecialitiesInteractor.swift
//  Smart Doc
//
//  Created by 17790204 on 30/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation
import UIKit

/// Интерфейс взаимодействия с интерактором экрана списка категорий специалистов
protocol DoctorSpecialitiesInteractable {}

/// Интерактор списка специальностей врачей
class DoctorSpecialitiesInteractor: DoctorSpecialitiesInteractable {

	func getRequest() {
		let resource = "RESOURCE"
		let method = "SEARCH"
		let params = "{SCHEDULE_ID:A4171FF0268A6E24E0530100007FF2C5}"

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


