//
//  OperationHistoryViewModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Вью-модель экрана OperationHistory.
struct OperationHistoryViewModel {

	var doctorSpecislities: [String] = []

	var starts: [String] = []

	var books: [Book] = []

	init(model: OperationHistoryModel) {

		for row in model.row {
			for book in row.book! {
				starts.append(book.START)
				doctorSpecislities.append(row.SPECIALITY)
				//specialitiesID.append(resourceId)
				print("Начало приема: \(book.START) специальность врача: \(row.SPECIALITY)")
			}
		}
	}

}
