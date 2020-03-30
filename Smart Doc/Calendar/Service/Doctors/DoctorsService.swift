//
//  DoctorsService.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Протокол сервиса получения фильмов.
protocol DoctorServicing {

	/// Возвращает массив жанров, либо ошибку.
	///
	/// - Parameter completion: Блок с результатом.
//	func fetchGenres(completion: @escaping (Result<[String], Error>) -> Void)

	/// Возвращает массив фильмов в прокате, либо ошибку.
	///
	/// - Parameters:
	///   - cityId: Идентификатор текущего города.
	///   - completion: Блок с результатом.
//	func fetchTodayMovies(cityId: UInt, completion: @escaping (Result<[MovieServiceModel.Movie], Error>) -> Void)

	/// Возвращает массив премьер, либо ошибку.
	///
	/// - Parameters:
	///   - cityId: Идентификатор текущего города.
	///   - completion: Блок с результатом.
//	func fetchPremieres(cityId: UInt, completion: @escaping (Result<[MovieServiceModel.Movie], Error>) -> Void)

	/// Возвращает детальную информацию о фильме.
	///
	/// - Parameters:
	///   - movieId: Идентификатор фильма.
	///   - completion: Блок с результатом.
//	func fetchMovieDetails(movieId: UInt, completion: @escaping (Result<MovieServiceModel.MovieDetails, Error>) -> Void)
}

/// Сервис получения фильмов.
final class DoctorService: DoctorServicing {

	// MARK: Constants

	private struct Constants {
		static let host = NetworkClientConstants.Doctors.host
		static let port = NetworkClientConstants.Doctors.port
		static let moviesPath = "/rambler/movies"
	}

	//private let networkClient: NetworkClientProtocol

//	init(networkClient: NetworkClientProtocol) {
//		self.networkClient = networkClient
//	}

	// MARK: MoviesServicing

//	func fetchGenres(completion: @escaping (Result<[String], Error>) -> Void) {
//		let path = Constants.moviesPath + "/genres"
//		let request = URLRequest(scheme: .http,
//								 host: Constants.host,
//								 port: Constants.port,
//								 path: path)
//		networkClient.perform(request) { result in
//			switch result {
//			case let .success(responseData):
//				do {
//					let response = try JSONDecoder().decode(BaseResponse<[String]>.self, from: responseData)
//					completion(.success(response.body))
//				} catch {
//					completion(.failure(NetworkClientError.responseDecodeFailure(error)))
//				}
//			case let .failure(error):
//				completion(.failure(error))
//			}
//		}
//	}



//	func fetchTodayMovies(cityId: UInt, completion: @escaping (Result<[MovieServiceModel.Movie], Error>) -> Void) {
//		let path = Constants.moviesPath + "/today/\(cityId)"
//		let request = URLRequest(scheme: .http,
//								 host: Constants.host,
//								 port: Constants.port,
//								 path: path)
//		networkClient.perform(request) { result in
//			switch result {
//			case let .success(responseData):
//				do {
//					let response = try JSONDecoder().decode(BaseResponse<[MovieServiceResponse.Movie]>.self, from: responseData)
//					let todayMovies = response.body.compactMap { $0.mapped }
//					completion(.success(todayMovies))
//				} catch {
//					completion(.failure(NetworkClientError.responseDecodeFailure(error)))
//				}
//			case let .failure(error):
//				completion(.failure(error))
//			}
//		}
//	}



//	func fetchPremieres(cityId: UInt, completion: @escaping (Result<[MovieServiceModel.Movie], Error>) -> Void) {
//		let path = Constants.moviesPath + "/premieres/\(cityId)"
//		let request = URLRequest(scheme: .http,
//								 host: Constants.host,
//								 port: Constants.port,
//								 path: path)
//		networkClient.perform(request) { result in
//			switch result {
//			case let .success(responseData):
//				do {
//					let response = try JSONDecoder().decode(BaseResponse<[MovieServiceResponse.Movie]>.self, from: responseData)
//					let premieres = response.body.compactMap { $0.mapped }
//					completion(.success(premieres))
//				} catch {
//					completion(.failure(NetworkClientError.responseDecodeFailure(error)))
//				}
//			case let .failure(error):
//				completion(.failure(error))
//			}
//		}
//	}



//	func fetchMovieDetails(movieId: UInt, completion: @escaping (Result<MovieServiceModel.MovieDetails, Error>) -> Void) {
//		let path = Constants.moviesPath + "/\(movieId)/details"
//		let request = URLRequest(scheme: .http,
//								 host: Constants.host,
//								 port: Constants.port,
//								 path: path)
//		networkClient.perform(request) { result in
//			switch result {
//			case let .success(responseData):
//				do {
//					let response = try JSONDecoder().decode(BaseResponse<MovieServiceResponse.MovieDetails>.self, from: responseData)
//					let movieDetails = response.body.mapped
//					completion(.success(movieDetails))
//				} catch {
//					completion(.failure(NetworkClientError.responseDecodeFailure(error)))
//				}
//			case let .failure(error):
//				completion(.failure(error))
//			}
//		}
//	}
}

// MARK: - Mapping

private func makeTrailerUrl(movieId: UInt) -> URL? {
	return URL(string: "https://mapi.kassa.rambler.ru/api/movie/\(movieId)/trailer")
}

private func makeDate(from string: String) -> Date? {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy-MM-dd"
	return formatter.date(from: string)
}

private func makeGenre(from genres: [String]) -> String {
	if genres.isEmpty { return "" }
	var genre = genres.reduce("") { result, genre -> String in
		result + ", " + genre
	}
	genre.remove(at: genre.startIndex)
	genre.remove(at: genre.startIndex)
	return genre
}

private extension MovieServiceResponse.Movie {

	var mapped: MovieServiceModel.Movie? {
		// Poster & Frame
		guard
			let posterPath = posterUrl,
			let posterUrl = URL(string: posterPath),
			let firstFrameUrl = framesUrls.first,
			let frameUrl = URL(string: firstFrameUrl) else { return nil }
		// Trailer
		let trailerUrl = makeTrailerUrl(movieId: id)
		// Release Date
		let releaseDate: Date? = makeDate(from: self.releaseDate)
		// Genere
		let genre = makeGenre(from: genres)
		return .init(id: id,
					 posterUrl: posterUrl,
					 frameUrl: frameUrl,
					// posterAverageColor: UIColor(white: 0, alpha: 0.66).cgColor,
					 title: name,
					 genre: genre,
					 trailerUrl: trailerUrl,
					 rating: Double(rating),
					 releaseDate: releaseDate)
	}
}

private extension MovieServiceResponse.MovieDetails {

	var mapped: MovieServiceModel.MovieDetails {
		// Poster & Frames
		let posterUrl: URL? = {
			guard let posterPath = self.posterUrl else { return nil }
			return URL(string: posterPath)
		}()
		let framesUrls = self.framesUrls.compactMap { URL(string: $0) }
		// Trailer
		let trailerUrl = makeTrailerUrl(movieId: id)
		// Release Date
		let releaseDate: Date? = makeDate(from: self.releaseDate)
		// Genere
		let genre = makeGenre(from: genres)
		return .init(id: id,
					 posterUrl: posterUrl,
					 framesUrls: framesUrls,
					// posterAverageColor: UIColor(white: 0, alpha: 0.66).cgColor,
					 title: name,
					 originalTitle: originalName,
					 genre: genre,
					 countries: countries,
					 trailerUrl: trailerUrl,
					 rating: Double(rating),
					 releaseDate: releaseDate,
					 director: director,
					 cast: actors,
					 description: movieDescription,
					 durationInMinutes: durationMinutes)
	}
}
