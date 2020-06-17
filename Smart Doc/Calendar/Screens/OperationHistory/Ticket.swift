//
//  TicketModel.swift
//  Smart Doc
//
//  Created by 17790204 on 14/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Модель талона на запись к врачу
struct Slot {

	/// массив с выбранными специализациями врачей для формирования талонов
	var specializationNames: [String] = []
	/// массив c временем для талонов на которые записался пациент
	var selectTime: [String] = []

	init(specializationNames: [String], selectTime: [String]) {
		self.specializationNames = specializationNames
		self.selectTime = selectTime
	}

}
