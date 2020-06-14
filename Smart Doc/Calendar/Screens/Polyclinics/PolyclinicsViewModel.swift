//
//  PolyclinicsViewModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 10/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Вью-модель экрана Polyclinics.
struct PolyclinicsViewModel {

	var organizations: [String]
	var organizatiosId: [String]

	init(model: PolyclinicModel) {
		organizations = model.rows.map { $0.organization }
		organizatiosId = model.rows.map { $0.id }
	}
}
