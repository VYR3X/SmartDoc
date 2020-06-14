//
//  SpecialitiesViewModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 17/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

struct SpecialitiesViewModel {

	/// Специализация врачей
	var specialitiesNames: [String] = []

	/// Имена персонала
	var doctorNames: [String] = []
	//var resources: [Resources]

	/// ID специальности
	var specialitiesID: [String] = []

	init(model: SpecialitiesModel) {

		specialitiesNames = model.groups.map {$0.name} // имя групп ( стоматологи терапевты и хирурги )
		let doctors = model.groups.map({$0.resources.map({doctorNames.append($0.doctorName)})})

		print("Doctors:\(doctors)")
		print("Doctors:\(doctorNames)")

		for group in model.groups {
			for resource in group.resources {
				let resourceId = resource.resourceID
				specialitiesID.append(resourceId)
				print("ID специалиста: \(resourceId) название: \(group.name)")

			}
		}
	}
}
