//
//  DoctorSpesialitiesService.swift
//  Smart Doc
//
//  Created by 17790204 on 02/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка категорий специалистов
protocol DoctorSpesialitiesServiceProtocol {

	func getRequest(polyclinicId: String?, completion: @escaping (Result<SpecialitiesModel, Error>) -> Void)
}

/// Интерактор списка специальностей врачей
class DoctorSpesialitiesService: DoctorSpesialitiesServiceProtocol {

	func getRequest(polyclinicId: String? = nil, completion: @escaping (Result<SpecialitiesModel, Error>) -> Void) {

		let resource = "RESOURCE"
		let method = "SEARCH"
		let param = polyclinicId ?? "A4171FF0268A6E24E0530100007FF2C5"
		// пака такая поликлиника хз остальное говно но все равно передать надо
		let params = "{SCHEDULE_ID:\"\(param)\"}"

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

		//print("URL: \(url)\n")

		session.dataTask(with: url!) { (data , responce, error) in

			print("Сформированный url: \(url)\n")
			print("Выбранная поликлиника: \(params)\n")


			if let responce = responce {
				//print(responce)
			}

			guard let data = data else { return }

			print("\n\nwin1251String\n\n")
			let win1251String = String(data: data, encoding: .windowsCP1251)

			guard let win1251Data = win1251String!.data(using: .utf8, allowLossyConversion: true) else {
				print("could not convert data")
				return
			}

			do {
				let specialities = try JSONDecoder().decode(SpecialitiesModel.self, from: win1251Data)
				completion(.success(specialities))
			}
			catch let jsonError {
				print("could not convert data to win1251 format")
				completion(.failure(jsonError)) // вместо print
			}

		}.resume()
	}
}
