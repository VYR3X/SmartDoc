//
//  Style.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

struct Colors {
	static var darkGray = #colorLiteral(red: 0.3764705882, green: 0.3647058824, blue: 0.3647058824, alpha: 1)
	static var darkRed = #colorLiteral(red: 0.5019607843, green: 0.1529411765, blue: 0.1764705882, alpha: 1)
	/// Основной цвет приложения темно-фиолетовый цвет
	static var mainColor = UIColor(red: 125/255, green: 0/255, blue: 235/255, alpha: 1)
	/// Светло зеленый цвет
	static var ligthGreenColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
}

/// Стиль приложения
struct Style {
	static var bgColor = UIColor.white
	static var monthViewLblColor = UIColor.white
	static var monthViewBtnRightColor = UIColor.white
	static var monthViewBtnLeftColor = UIColor.white
	static var activeCellLblColor = UIColor.white
	static var activeCellLblColorHighlighted = UIColor.black
	static var weekdaysLblColor = UIColor.white


	/// Темная тема приложения
	static func themeDark() {
		bgColor = Colors.darkGray
		monthViewLblColor = UIColor.white
		monthViewBtnRightColor = UIColor.white
		monthViewBtnLeftColor = UIColor.white
		activeCellLblColor = UIColor.white
		activeCellLblColorHighlighted = UIColor.black
		weekdaysLblColor = UIColor.white
	}

	/// Светлая тема приложения
	static func themeLight() {
		bgColor = UIColor.white
		monthViewLblColor = UIColor.black
		monthViewBtnRightColor = UIColor.black
		monthViewBtnLeftColor = UIColor.black
		activeCellLblColor = UIColor.black
		activeCellLblColorHighlighted = UIColor.white
		weekdaysLblColor = UIColor.black
	}
}
