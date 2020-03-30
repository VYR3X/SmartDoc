//
//  DoctorsServiceModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Пространство имён моделей сервиса.
struct MovieServiceModel {

	/// Mодель фильма.
	struct Movie {
		let id: UInt
		let posterUrl: URL?
		let frameUrl: URL
		//let posterAverageColor: CGColor?
		let title: String
		let genre: String
		let trailerUrl: URL?
		let rating: Double?
		let releaseDate: Date?
	}

	/// Модель с дополнительной информацией о фильме.
	struct MovieDetails {
		let id: UInt
		let posterUrl: URL?
		let framesUrls: [URL]
	//	let posterAverageColor: CGColor?
		let title: String
		let originalTitle: String
		let genre: String
		let countries: String
		let trailerUrl: URL?
		let rating: Double?
		let releaseDate: Date?
		let director: String
		let cast: String
		let description: String
		let durationInMinutes: Int?
	}
}

/// Пространство имен ответов сетевого клиента для сервиса.
struct MovieServiceResponse {

	/// Фильм.
	struct Movie: Decodable {
		let id: UInt
		let name: String
		let ageRating: String?
		let rating: String
		let posterUrl: String?
		let maxRating: Int
		let releaseDate: String
		let durationMinutes: Int?
		let genres: [String]
		let countries: String
		let framesUrls: [String]
	}

	/// Информация о фильме.
	struct MovieDetails: Decodable {
		let id: UInt
		let name: String
		let ageRating: String?
		let rating: String
		let posterUrl: String?
		let releaseDate: String
		let durationMinutes: Int?
		let genres: [String]
		let countries: String
		let framesUrls: [String]
		let originalName: String
		let director: String
		let actors: String
		let movieDescription: String
	}
}
