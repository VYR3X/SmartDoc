//
//  DoctorSpecialitiesInteractor.swift
//  Smart Doc
//
//  Created by 17790204 on 30/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка категорий специалистов
protocol DoctorSpecialitiesInteractable {

	func getRequest(completion: @escaping (Result<SpecialitiesModel, Error>) -> Void)
}

/// Интерактор списка специальностей врачей
class DoctorSpecialitiesInteractor: DoctorSpecialitiesInteractable {

	func getRequest(completion: @escaping (Result<SpecialitiesModel, Error>) -> Void) {

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

			print("\n\nwin1251String\n\n")
			let win1251String = String(data: data, encoding: .windowsCP1251)

			guard let win1251Data = win1251String!.data(using: .utf8, allowLossyConversion: true) else {
				print("could not convert data")
				return
			}

			do {
				let slots = try JSONDecoder().decode(SpecialitiesModel.self, from: win1251Data)
				completion(.success(slots))

			}
			catch let jsonError {
				print("could not convert data to win1251 format")
				completion(.failure(jsonError)) // вместо print
			}

		}.resume()

//		let session = URLSession.shared
//
//		session.dataTask(with: url!) { (data , responce, error) in
//
//			if let responce = responce {
//				print(responce)
//			}
//
//			guard let data = data else { return }
//			guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
//				print("could not convert data to UTF-8 format")
//				return
//			}
//
//			do {
//				let interinData = try JSONSerialization.jsonObject(with: utf8Data, options: .mutableContainers)
//				print(interinData)
//			}
//			catch {
//				print(error)
//			}
//		}.resume()
	}
}


