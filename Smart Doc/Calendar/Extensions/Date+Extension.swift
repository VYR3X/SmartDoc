//
//  Date+Extension.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

// MARK: - Date

extension Date {
	/// День недели
	var weekday: Int {
		return Calendar.current.component(.weekday, from: self) - 1
	}
	/// Первый день месяца
	var firstDayOfTheMonth: Date {
		return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
	}
}

// Получение даты из строки
extension String {
	static var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()

	var date: Date? {
		return String.dateFormatter.date(from: self)
	}
}
