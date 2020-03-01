//
//  MonthView.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс смены месяца
protocol MonthViewDelegate: class {
	/// Метод для смены месяца
	func didChangeMonth(monthIndex: Int, year: Int)
}

/// Вью с месяцем
final class MonthView: UIView {
	/// публичное свойство делегат
	var delegate: MonthViewDelegate?

	/// свойство отображающее название месяца и год
	let currentMonthLabel: UILabel = {
		let lbl = UILabel()
		lbl.text = "Default Month Year text"
		lbl.textColor = Style.monthViewLblColor
		lbl.textAlignment = .center
		lbl.font=UIFont.boldSystemFont(ofSize: 16)
		lbl.translatesAutoresizingMaskIntoConstraints=false
		return lbl
	}()

	/// правая кнопка навигационного бара
	let rightNavigationBarButton: UIButton = {
		let btn = UIButton()
		btn.setTitle(">", for: .normal)
		btn.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
		return btn
	}()

	/// левая кнопка навигационного бара
	let leftNavigationBarButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("<", for: .normal)
		btn.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
		btn.setTitleColor(UIColor.lightGray, for: .disabled)
		return btn
	}()

	private var monthsArr = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]

	/// текущий месяц ( определяется по индексу )
	private var currentMonthIndex = 0
	private var currentYear: Int = 0

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clear

		setupYearWithMonth()
		setupViews()

		leftNavigationBarButton.isEnabled = false
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	@objc func btnLeftRightAction(sender: UIButton) {
		if sender == rightNavigationBarButton {
			currentMonthIndex += 1
			if currentMonthIndex > 11 {
				currentMonthIndex = 0
				currentYear += 1
			}
		} else {
			currentMonthIndex -= 1
			if currentMonthIndex < 0 {
				currentMonthIndex = 11
				currentYear -= 1
			}
		}
		currentMonthLabel.text="\(monthsArr[currentMonthIndex]) \(currentYear)"

		delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
	}

	/// метод для определения года и месяца
	private func setupYearWithMonth() {
		currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
		currentYear = Calendar.current.component(.year, from: Date())
	}

	private func setupViews() {

		self.addSubview(currentMonthLabel)
		self.addSubview(rightNavigationBarButton)
		self.addSubview(leftNavigationBarButton)

		NSLayoutConstraint.activate([

		currentMonthLabel.topAnchor.constraint(equalTo: topAnchor),
		currentMonthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
		currentMonthLabel.widthAnchor.constraint(equalToConstant: 150),
		currentMonthLabel.heightAnchor.constraint(equalTo: heightAnchor),

		rightNavigationBarButton.topAnchor.constraint(equalTo: topAnchor),
		rightNavigationBarButton.rightAnchor.constraint(equalTo: rightAnchor),
		rightNavigationBarButton.widthAnchor.constraint(equalToConstant: 50),
		rightNavigationBarButton.heightAnchor.constraint(equalTo: heightAnchor),

		leftNavigationBarButton.topAnchor.constraint(equalTo: topAnchor),
		leftNavigationBarButton.leftAnchor.constraint(equalTo: leftAnchor),
		leftNavigationBarButton.widthAnchor.constraint(equalToConstant: 50),
		leftNavigationBarButton.heightAnchor.constraint(equalTo: heightAnchor)
		])

		currentMonthLabel.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
	}
}

