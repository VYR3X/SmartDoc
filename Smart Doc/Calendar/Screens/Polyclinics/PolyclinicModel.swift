//
//  PolyclinicModel.swift
//  Smart Doc
//
//  Created by 17790204 on 01/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

// MARK: - Interin
struct PolyclinicModel: Codable {
    let rows: [Row]

    enum CodingKeys: String, CodingKey {
        case rows = "ROWS"
    }
}

// MARK: - Row
struct Row: Codable {
    let db, type, id: String
    let rev, status: Int
    let modified, author, code, name: String
    let instance, instanceName, rowDescription, organizationID: String
    let organization: String

    enum CodingKeys: String, CodingKey {
        case db = "_DB"
        case type = "_TYPE"
        case id = "_ID"
        case rev = "_REV"
        case status = "_STATUS"
        case modified = "_MODIFIED"
        case author = "_AUTHOR"
        case code = "CODE"
        case name = "NAME"
        case instance = "INSTANCE"
        case instanceName = "INSTANCE_NAME"
        case rowDescription = "DESCRIPTION"
        case organizationID = "ORGANIZATION_ID"
        case organization = "ORGANIZATION"
    }
}
