//
//  SlotViewModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 13/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

// MARK: - Interin

struct SlotViewModel {

	var slotsCount: Int

	var doctorSpecislitiesID: [String]

	var timeShow: [String]

	var dateShow: [String]

	var start: [String]

	/// Состояние возможнали запись 0 - свободен или 1 - занят
	var state: [Int]?

	init(model: TicketModel) {
		slotsCount = model.row.count
		// если 0 - тогда берем в рассмотрение талон, иначе зачем он нам нужен )
		doctorSpecislitiesID = model.row.filter{ $0.STATE == 0 }.map{$0.id}
		timeShow = model.row.filter{ $0.STATE == 0 }.map{$0.TIME_SHOW}
		dateShow = model.row.filter{ $0.STATE == 0 }.map{$0.DATE_SHOW}
		start = model.row.filter{ $0.STATE == 0 }.map{$0.start}
	}
}

