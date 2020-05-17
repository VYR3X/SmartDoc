//
//  FlowCoordinating.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 12/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Интерфейс взаимодействия с флоу координатором
protocol FlowCoordinating {

	/// Старт флоу
	func startFlow()

	/// Закончить флоу
	func finishFlow()
}
