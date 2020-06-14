//
//  DoctorsService.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка категорий специалистов
protocol DoctorsServiceProtocol {

	func getRequest(completion: @escaping (Result<PolyclinicModel, Error>) -> Void)
}

/// Интерактор списка специальностей врачей
class DoctorsService: DoctorsServiceProtocol {

	func getRequest(completion: @escaping (Result<PolyclinicModel, Error>) -> Void) {

		let resource = "SCHEDULE"
		let method = "SEARCH"
		let params = "{}"

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
				let polyclinics = try JSONDecoder().decode(PolyclinicModel.self, from: win1251Data)
				completion(.success(polyclinics))
			}
			catch let jsonError {
				print("could not convert data to win1251 format")
				completion(.failure(jsonError)) // вместо print
			}

		}.resume()
	}
}

