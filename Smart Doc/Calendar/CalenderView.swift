//
//  CalenderView.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Календарь
final class CalenderView: UIView {

	/// коллектион вью содержащий все дни месяца
	let daysCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

		let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		myCollectionView.showsHorizontalScrollIndicator = false
		myCollectionView.translatesAutoresizingMaskIntoConstraints = false
		myCollectionView.backgroundColor = UIColor.clear
		myCollectionView.allowsMultipleSelection = false
		return myCollectionView
	}()

	var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
	var currentMonthIndex: Int = 0
	var currentYear: Int = 0
	var presentMonthIndex = 0
	var presentYear = 0
	var todaysDate = 0
	var firstWeekDayOfMonth = 0  //0   //(Sunday-Saturday 1-7)

	private lazy var monthView: MonthView = {
		let view = MonthView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.delegate = self
		return view
	}()

	private let weekdaysView: WeekdaysView = {
		let view = WeekdaysView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		initializeView()
	}

	convenience init(theme: MyTheme) {
		self.init()

		if theme == .dark {
			Style.themeDark()
		} else {
			Style.themeLight()
		}
		initializeView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	func changeTheme() {
		daysCollectionView.reloadData()

		monthView.currentMonthLabel.textColor = Style.monthViewLblColor
		monthView.rightNavigationBarButton.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
		monthView.leftNavigationBarButton.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)

		for i in 0..<7 {
			(weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
		}
	}

	func initializeView() {
		currentMonthIndex = Calendar.current.component(.month, from: Date())
		currentYear = Calendar.current.component(.year, from: Date())
		todaysDate = Calendar.current.component(.day, from: Date())
		firstWeekDayOfMonth = getFirstWeekDay()

		//for leap years, make february month of 29 days
		if currentMonthIndex == 2 && currentYear % 4 == 0 {
			numOfDaysInMonth[currentMonthIndex - 1] = 29
		}
		//end

		presentMonthIndex = currentMonthIndex
		presentYear = currentYear

		setupViews()

		daysCollectionView.delegate = self
		daysCollectionView.dataSource = self
		daysCollectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
	}

	private func getFirstWeekDay() -> Int {
		let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
		return day
		//return day == 7 ? 1 : day
	}

	private func setupViews() {

		addSubview(monthView)
		addSubview(weekdaysView)
		addSubview(daysCollectionView)

		NSLayoutConstraint.activate([
			monthView.topAnchor.constraint(equalTo: topAnchor),
			monthView.leftAnchor.constraint(equalTo: leftAnchor),
			monthView.rightAnchor.constraint(equalTo: rightAnchor),
			monthView.heightAnchor.constraint(equalToConstant: 35),

			weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
			weekdaysView.leftAnchor.constraint(equalTo: leftAnchor),
			weekdaysView.rightAnchor.constraint(equalTo: rightAnchor),
			weekdaysView.heightAnchor.constraint(equalToConstant: 30),

			daysCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0),
			daysCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
			daysCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
			daysCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

}

// MARK: - MonthViewDelegate

extension CalenderView: MonthViewDelegate {

	func didChangeMonth(monthIndex: Int, year: Int) {

		currentMonthIndex = monthIndex + 1
		currentYear = year

		// определение количества дней в феврале
		if monthIndex == 1 {
			if currentYear % 4 == 0 {
				numOfDaysInMonth[monthIndex] = 29
			} else {
				numOfDaysInMonth[monthIndex] = 28
			}
		}

		firstWeekDayOfMonth = getFirstWeekDay()

		daysCollectionView.reloadData()

		monthView.leftNavigationBarButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
	}
}

// MARK: - Date

extension Date {
	/// День недели
	var weekday: Int {
		return Calendar.current.component(.weekday, from: self) - 1
	}
	/// Первый день месяца
	var firstDayOfTheMonth: Date {
		return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
	}
}

//get date from string
extension String {
	static var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()

	var date: Date? {
		return String.dateFormatter.date(from: self)
	}
}

// MARK: - UICollectionViewDelegate

extension CalenderView: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		cell?.backgroundColor = Colors.darkRed
		let lbl = cell?.subviews[1] as! UILabel
		lbl.textColor = UIColor.white
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		cell?.backgroundColor = UIColor.clear
		let lbl = cell?.subviews[1] as! UILabel
		lbl.textColor = Style.activeCellLblColor
	}

}

// MARK: - UICollectionViewDataSource

extension CalenderView: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		 return numOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DayCollectionViewCell
		cell.backgroundColor = UIColor.clear

		if indexPath.item <= firstWeekDayOfMonth - 2 { // - 2
			cell.isHidden = true
		} else {
			let calcDate = indexPath.row - firstWeekDayOfMonth + 2
			cell.isHidden = false
			cell.dayLabel.text = "\(calcDate)"
			if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
				cell.isUserInteractionEnabled = false
				cell.dayLabel.textColor = UIColor.lightGray
			} else {
				cell.isUserInteractionEnabled = true
				cell.dayLabel.textColor = Style.activeCellLblColor
			}
		}
		return cell
	}

}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalenderView: UICollectionViewDelegateFlowLayout {

		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			let width = collectionView.frame.width / 7 - 8 
			let height: CGFloat = 40
			return CGSize(width: width, height: height)
		}

		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
			return 8.0
		}

		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
			return 8.0
		}
}
