//
//  FlowCoordinating.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 12/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с флоу координатором
protocol FlowCoordinating {

	/// Старт флоу
	func startFlow()

	/// Закончить флоу
	/// - Parameters:
	///   - time: время hh:mm
	///   - date: дата приема к врачу
	func finishFlow(time: String, date: String)

	func createNavigationContoller(vc: UIViewController) -> UINavigationController //UINavigationController
}
