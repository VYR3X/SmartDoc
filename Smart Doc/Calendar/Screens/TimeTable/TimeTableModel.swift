//
//  TimeTableModel.swift
//  Smart Doc
//
//  Created by 17790204 on 05/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

// MARK: - TimeTableModel

struct TimeTableModel: Decodable {

	var id: String
	var bookId: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
		case bookId = "BOOK_ID"
    }
}
