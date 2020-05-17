//
//  SpecialitiesModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

// MARK: - SpecialitiesModel

struct SpecialitiesModel: Codable {
    let id: String
    let groups: [Group]

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case groups = "GROUPS"
    }
}

// MARK: - Group

struct Group: Codable {
    let db, type, groupID: String
    let rev, groupStatus: Int
    let modified, author, name, code: String
    let seq, statusText: String
    let status: Status
    let resources: [Resource]
    let delTitle, id: String?

    enum CodingKeys: String, CodingKey {
        case db = "_DB"
        case type = "_TYPE"
        case groupID = "_ID"
        case rev = "_REV"
        case groupStatus = "_STATUS"
        case modified = "_MODIFIED"
        case author = "_AUTHOR"
        case name = "NAME"
        case code = "CODE"
        case seq = "SEQ"
        case statusText = "STATUS_TEXT"
        case status = "STATUS"
        case resources = "RESOURCES"
        case delTitle = "DEL_TITLE"
        case id = "ID"
    }
}

// MARK: - Resource

struct Resource: Codable {
    let db, type, id: String
    let rev, status: Int
    let modified, author, resourcePrefix, groupID: String
    let groupName, instance, instanceName, organizationID: String
    let organization, departmentID, departmentName, specialityID: String
    let specialityName, doctorID, doctorName, roomID: String
    let roomName, defLength, raspsShow, seq: String
    let resourceDescription: String
    let showWeb, showTerminal, limited: Bool
    let srvs: [Srv]
    let name: String
    let specID, specName, orgID, orgName: String?
    let comments: String?

    enum CodingKeys: String, CodingKey {
        case db = "_DB"
        case type = "_TYPE"
        case id = "_ID"
        case rev = "_REV"
        case status = "_STATUS"
        case modified = "_MODIFIED"
        case author = "_AUTHOR"
        case resourcePrefix = "PREFIX"
        case groupID = "GROUP_ID"
        case groupName = "GROUP_NAME"
        case instance = "INSTANCE"
        case instanceName = "INSTANCE_NAME"
        case organizationID = "ORGANIZATION_ID"
        case organization = "ORGANIZATION"
        case departmentID = "DEPARTMENT_ID"
        case departmentName = "DEPARTMENT_NAME"
        case specialityID = "SPECIALITY_ID"
        case specialityName = "SPECIALITY_NAME"
        case doctorID = "DOCTOR_ID"
        case doctorName = "DOCTOR_NAME"
        case roomID = "ROOM_ID"
        case roomName = "ROOM_NAME"
        case defLength = "DEF_LENGTH"
        case raspsShow = "RASPS_SHOW"
        case seq = "SEQ"
        case resourceDescription = "DESCRIPTION"
        case showWeb = "SHOW_WEB"
        case showTerminal = "SHOW_TERMINAL"
        case limited = "LIMITED"
        case srvs = "SRVS"
        case name = "NAME"
        case specID = "SPEC_ID"
        case specName = "SPEC_NAME"
        case orgID = "ORG_ID"
        case orgName = "ORG_NAME"
        case comments = "COMMENTS"
    }
}

// MARK: - Srv

struct Srv: Codable {
    let active: Bool
    let code, name, length, id: String
    let rn: Int

    enum CodingKeys: String, CodingKey {
        case active = "ACTIVE"
        case code = "CODE"
        case name = "NAME"
        case length = "LENGTH"
        case id = "ID"
        case rn = "_RN"
    }
}

enum Status: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Status.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Status"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

