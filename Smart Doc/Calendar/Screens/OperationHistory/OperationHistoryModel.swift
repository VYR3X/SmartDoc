//
//  OperationHistoryModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Пространство имен модели экрана OperationHistory.
import Foundation

// MARK: - TicketModel

struct OperationHistoryModel: Decodable {

	var row: [ROWS]

    enum CodingKeys: String, CodingKey {
        case row = "ROWS"
    }
}

struct ROWS: Decodable {
	var id: String
//	var start: String
//	var END: String
//	var DATE_SHOW: String
//	var TIME_SHOW: String
//	var RESOURCE_ID: String
//	var DOCTOR: String
//	var GROUP: String
	var SPECIALITY: String
//	var DEPARTMENT: String
//	var ROOM: String
//	var TYPE: String
//	var INSTANCE: String
//	var INSTANCE_NAME: String
//	var ORGANIZATION_ID: String
	var book: [Book]?

	enum CodingKeys: String, CodingKey {
		case id = "ID"
//		case start = "START"
//		case END = "END"
//		case DATE_SHOW = "DATE_SHOW"
//		case TIME_SHOW = "TIME_SHOW"
//		case RESOURCE_ID = "RESOURCE_ID"
//		case DOCTOR = "DOCTOR"
//		case GROUP = "GROUP"
		case SPECIALITY = "SPECIALITY"
//		case DEPARTMENT = "DEPARTMENT"
//		case ROOM = "ROOM"
//		case TYPE = "TYPE"
//		case INSTANCE = "INSTANCE"
//		case INSTANCE_NAME = "INSTANCE_NAME"
//		case ORGANIZATION_ID = "ORGANIZATION_ID"
		case book = "BOOK"
	}
}

struct Book: Decodable {
	var DB: String
	var TYPE: String
	var ID: String
	var REV: Int
	var STATUS: Int
	var MODIFIED: String
	var AUTHOR: String
	var START: String
	var END: String
	var PARENT_ID: String
	var PERSON_ID: String
	var PATIENT_ID: String
	var CHART_ID: String
	var PAYMENT_ID: String
	var PATIENT_NAME: String
	var PATIENT_LASTNAME: String
	var PATIENT_BIRTHDAY: String
	var PATIENT_PHONE: String
	var PATIENT_EMAIL: String
	var COMMENTS: String
	var RESOURCE_ID: String
	var ORGANIZATION_ID: String
	var INSTANCE: String

	enum CodingKeys: String, CodingKey {
		case DB = "_DB"
		case TYPE = "_TYPE"
		case ID = "_ID"
		case REV = "_REV"
		case STATUS = "_STATUS"
		case MODIFIED = "_MODIFIED"
		case AUTHOR = "_AUTHOR"
		case START = "START"
		case END = "END"
		case PARENT_ID = "PARENT_ID"
		case PERSON_ID = "PERSON_ID"
		case PATIENT_ID = "PATIENT_ID"
		case CHART_ID = "CHART_ID"
		case PAYMENT_ID = "PAYMENT_ID"
		case PATIENT_NAME = "PATIENT_NAME"
		case PATIENT_LASTNAME = "PATIENT_LASTNAME"
		case PATIENT_BIRTHDAY = "PATIENT_BIRTHDAY"
		case PATIENT_PHONE = "PATIENT_PHONE"
		case PATIENT_EMAIL = "PATIENT_EMAIL"
		case COMMENTS = "COMMENTS"
		case RESOURCE_ID = "RESOURCE_ID"
		case ORGANIZATION_ID = "ORGANIZATION_ID"
		case INSTANCE = "INSTANCE"
	}
}
