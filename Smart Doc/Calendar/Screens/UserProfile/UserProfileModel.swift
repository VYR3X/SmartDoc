//
//  UserProfileModel.swift
//  Smart Doc
//
//  Created by 17790204 on 09/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

// Модель содержащая информацию по пользователю
class UserProfileModel: NSObject, NSCoding {

	let name: String
	let birthdate: String
	let telephone: String
	let email: String
	let polis: String

	init(name: String, birthdate: String, telephone: String, email: String, polis: String) {
		self.name = name
		self.birthdate = birthdate
		self.telephone = telephone
		self.email = email
		self.polis = polis
	}

	func encode(with coder: NSCoder) {
		coder.encode(name, forKey: "name")
		coder.encode(birthdate, forKey: "birthdate")
		coder.encode(telephone, forKey: "telephone")
		coder.encode(email, forKey: "email")
		coder.encode(polis, forKey: "polis")
	}

	required init?(coder: NSCoder) {
		name = coder.decodeObject(forKey: "name") as? String ?? ""
		birthdate = coder.decodeObject(forKey: "birthdate") as? String ?? ""
		telephone = coder.decodeObject(forKey: "telephone") as? String ?? ""
		email = coder.decodeObject(forKey: "email") as? String ?? ""
		polis = coder.decodeObject(forKey: "polis") as? String ?? ""
	}
}
