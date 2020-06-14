//
//  DoctorsInteractor.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана Doctors
protocol DoctorsInteractable {}

/// Интерактор экрана со списком имен врачей
final class DoctorsInteractor: DoctorsInteractable {

	/// Сервис для работы с дип линками
	private let doctorsService: DoctorsServiceProtocol

	/// Конструктор интерактора экрана доп информации по поликлиникам
	/// - Parameter polyclinicService: серви для поликлиник
	init(doctorsService: DoctorsServiceProtocol) {
		self.doctorsService = doctorsService
	}
	
}
