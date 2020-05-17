//
//  SpecialitiesViewModel.swift
//  Smart Doc
//
//  Created by 17790204 on 17/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

struct SpecialitiesViewModel {

	var specialitiesNames: [String]

	init(model: SpecialitiesModel) {
		specialitiesNames = model.groups.map {$0.name} // имя групп ( стоматологи терапевты и хирурги )
//		doctorSpecislitiesID = model.groups.map {$0.}
	}
}
