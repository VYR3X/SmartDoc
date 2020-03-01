//
//  WeekdaysView.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Вью показывающее дни недели
class WeekdaysView: UIView {

	private var daysArr = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]

	/// стэк вью с днями недели
	let myStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clear
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupViews() {
		addSubview(myStackView)
		myStackView.topAnchor.constraint(equalTo: topAnchor).isActive=true
		myStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
		myStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
		myStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true

		for i in 0..<7 {
			let lbl = UILabel()
			lbl.text = daysArr[i]
			lbl.textAlignment = .center
			lbl.textColor = Style.weekdaysLblColor
			myStackView.addArrangedSubview(lbl)
		}
	}
}

