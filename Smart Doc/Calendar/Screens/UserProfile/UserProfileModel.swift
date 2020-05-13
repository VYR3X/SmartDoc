//
//  UserProfileModel.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 09/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Модель содержащая информацию по пользователю
class UserProfileModel: NSObject, NSCoding {

	/// фио пользователя
	var name: String = ""
	/// дата рождения
	var birthdate: String = ""
	/// телефон
	var telephone: String = ""
	/// почта
	var email: String = ""
	/// номер полиса
	var polis: String = ""

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
		name = coder.decodeObject(forKey: "name") as? String ?? "имя"
		birthdate = coder.decodeObject(forKey: "birthdate") as? String ?? "дата рождения"
		telephone = coder.decodeObject(forKey: "telephone") as? String ?? "телефон"
		email = coder.decodeObject(forKey: "email") as? String ?? "почта"
		polis = coder.decodeObject(forKey: "polis") as? String ?? "полис"
	}
}
