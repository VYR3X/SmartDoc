//
//  UserSettings.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 09/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation

/// Настройки экрана профиль (сохранение значений в UserDefaults)
final class UserSettings {

	private enum SettingsKeys: String {
		case userName
		case userModel
	}

	/// Сохраняемая модель с данными пользователя в UserDefaults
	static var userModel: UserProfileModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data,
				let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserProfileModel else { return nil }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue

            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    print("value: \(userModel) was added to key \(key)")
                    defaults.set(savedData, forKey: key)
                } else {
                    defaults.removeObject(forKey: key)
                }
            }
        }
    }

	/// Сохраняем только ФИО пользователя в UserDefaults
	static var userFIO: String! {

		get {
			return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
		} set {

			let defaults = UserDefaults.standard
			let key = SettingsKeys.userName.rawValue

			if let name = newValue {
				print("value \(name), was add for key \(key)")
				defaults.set(name, forKey: key)
			} else {
				defaults.removeObject(forKey: key)
			}

		}
	}
}
