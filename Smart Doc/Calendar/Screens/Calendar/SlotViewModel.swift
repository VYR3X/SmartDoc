//
//  SlotViewModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 13/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

// MARK: - Interin

/// Вью Модель талона на запись
struct SlotViewModel {

	/// Количество талонов на запись к врачу
	var slotsCount: Int

	/// ID специализации врача для записи
	var doctorSpecislitiesID: [String] = []

	/// Время записи на прием к врачу в формате 08:00
	var timeShow: [String] = []

	var dateShow: [String] = []

	var start: [String] = []

	/// Состояние возможнали запись 0 - свободен или 1 - занят
	var state: [Int]?

	init(model: TicketModel) {
		slotsCount = model.row.count
		// если 0 - тогда берем в рассмотрение талон, иначе зачем он нам нужен )
		doctorSpecislitiesID = model.row.filter{ $0.STATE == 0 }.map{$0.id}
		state = model.row.map{$0.STATE}
		let time = model.row.filter{ $0.STATE == 0 }.map{$0.TIME_SHOW}
		getSubString(time: time)
		dateShow = model.row.filter{ $0.STATE == 0 }.map{$0.DATE_SHOW}
		start = model.row.filter{ $0.STATE == 0 }.map{$0.start}
	}

	/// Приходит дата: 08:20-08:40 на выходе получим подстроку вида: 08:20
	private mutating func getSubString(time: [String]) {
		for object in time {
			let subString = String(object.dropLast(6))
			timeShow.append(subString)
		}
	}
}

