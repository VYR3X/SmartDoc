//
//  TicketModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 13/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

// MARK: - TicketModel

struct TicketModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case row = "ROWS"
    }
    let row: [ROW]
}

struct ROW: Decodable {
	var id: String
	var start: String
	var END: String
	var DATE_SHOW: String
	var TIME_SHOW: String
	var RESOURCE_ID: String
	var DOCTOR: String
	var GROUP: String
	var SPECIALITY: String
	var DEPARTMENT: String
	var ROOM: String
	var TYPE: String
	var INSTANCE: String
	var INSTANCE_NAME: String
	var ORGANIZATION_ID: String
	var STATE: Int // 0 - можно записаться , 1 - то не записаться )
	var STATE_NAME: String
	var ACTION_CSS: String
	var ACTION: Int // 1 - запись возможна
	var ACTION_NAME: String

	enum CodingKeys: String, CodingKey {
		case id = "ID"
		case start = "START"
		case END = "END"
		case DATE_SHOW = "DATE_SHOW"
		case TIME_SHOW = "TIME_SHOW"
		case RESOURCE_ID = "RESOURCE_ID"
		case DOCTOR = "DOCTOR"
		case GROUP = "GROUP"
		case SPECIALITY = "SPECIALITY"
		case DEPARTMENT = "DEPARTMENT"
		case ROOM = "ROOM"
		case TYPE = "TYPE"
		case INSTANCE = "INSTANCE"
		case INSTANCE_NAME = "INSTANCE_NAME"
		case ORGANIZATION_ID = "ORGANIZATION_ID"
		case STATE = "STATE"
		case STATE_NAME = "STATE_NAME"
		case ACTION_CSS = "ACTION_CSS"
		case ACTION = "ACTION"
		case ACTION_NAME = "ACTION_NAME"
	}
}
