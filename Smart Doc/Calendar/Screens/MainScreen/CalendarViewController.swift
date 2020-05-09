//
//  CalendarView.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана CalendarViewController.
protocol CalendarViewControllable {}

/// Интерфейс взаимодействия с презентером экрана CalendarViewController.
protocol CalendarPresentableListener {

	/// Данные загрузились
	///
	/// - Parameter viewController: текущий вью контроллер
	func didLoad(_ viewController: UIViewController)

	/// Информирует листенер о нажатии кнопки назад.
	///
	/// - Parameter viewController: Вью-контроллера экрана CalendarViewController.
	func didPressBack(_ viewController: UIViewController)

	/// Информирует листенер о переходе на экран с врачами
	func didPressDoctors()

	/// Пользователь выбрал дату в календаре
	/// - Parameters:
	///   - date: Выбранная дата
	///   - resourceID: Выбранная специлизация врача (хирург, терапевт, стоматолог...)
	func personSelectDate(date: String, resourceID: String)
}

/// Выбор темы приложения
enum MyTheme {
	case light
	case dark
}

/// Календарь
class CalendarViewController: UIViewController {

	private var theme = MyTheme.dark

	/// Листенер экрана CalendarViewController
	var listener: CalendarPresentableListener?

	/// Специализация врача
	var resourseID: String?

	/// Вью выбора дня в календаре (все дни месяца) 
	let daysView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 20
		// настойка тени
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 1
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 3

		return view
	}()

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
	var firstWeekDayOfMonth = 1  //0   //(Sunday-Saturday 1-7)

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

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		daysCollectionView.collectionViewLayout.invalidateLayout()
	}

	init(listener: CalendarPresentableListener) {
		super.init(nibName: nil, bundle: nil)
		self.listener = listener
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		listener?.didLoad(self)
		self.title = "Calendar"
		self.navigationController?.navigationBar.isTranslucent = false


//		let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
//		self.navigationItem.rightBarButtonItem = rightBarBtn

		initializeView()
		setupViews()

	}


//	@objc func rightBarBtnAction(sender: UIBarButtonItem) {
//		if theme == .dark {
//			sender.title = "Dark"
//			theme = .light
//			Style.themeLight()
//		} else {
//			sender.title = "Light"
//			theme = .dark
//			Style.themeDark()
//		}
//		self.view.backgroundColor = Style.bgColor
//		changeTheme()
//	}

	func initializeView() {

		setupStyleInApplication()

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

//		setupViews()

		daysCollectionView.delegate = self
		daysCollectionView.dataSource = self
		daysCollectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
	}

	private func setupStyleInApplication(){
		if theme == .dark {
			theme = .light
			Style.themeLight()
		} else {
			theme = .dark
			Style.themeDark()
		}
		self.view.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
		//self.view.backgroundColor = Style.bgColor
		changeTheme()
	}

	private func changeTheme() {
		daysCollectionView.reloadData()

		monthView.currentMonthLabel.textColor = Style.monthViewLblColor
		monthView.rightNavigationBarButton.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
		monthView.leftNavigationBarButton.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)

		for i in 0..<7 {
			(weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
		}
	}

	private func getFirstWeekDay() -> Int {
		let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
		return day
	}

	private func setupViews() {

		view.addSubview(monthView)
		view.addSubview(weekdaysView)
		view.addSubview(daysView)
		daysView.addSubview(daysCollectionView)

		NSLayoutConstraint.activate([
			monthView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
			monthView.leftAnchor.constraint(equalTo: view.leftAnchor),
			monthView.rightAnchor.constraint(equalTo: view.rightAnchor),
			monthView.heightAnchor.constraint(equalToConstant: 35),

			weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
			weekdaysView.leftAnchor.constraint(equalTo: view.leftAnchor),
			weekdaysView.rightAnchor.constraint(equalTo: view.rightAnchor),
			weekdaysView.heightAnchor.constraint(equalToConstant: 30),

			daysView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0),
			daysView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			daysView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			daysView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),

			daysCollectionView.topAnchor.constraint(equalTo: daysView.topAnchor, constant: 0),
			daysCollectionView.leftAnchor.constraint(equalTo: daysView.leftAnchor, constant: 0),
			daysCollectionView.rightAnchor.constraint(equalTo: daysView.rightAnchor, constant: 0),
			daysCollectionView.bottomAnchor.constraint(equalTo: daysView.bottomAnchor, constant: 0),
		])
	}

}

// MARK: - MonthViewDelegate

extension CalendarViewController: MonthViewDelegate {

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

		/// отмена пролистывания влево 
		monthView.leftNavigationBarButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
	}
}

// MARK: - UICollectionViewDelegate

extension CalendarViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		cell?.backgroundColor = Colors.darkRed
		let selectDay = cell?.subviews[1] as! UILabel
		selectDay.textColor = UIColor.white

		let bdate = String(selectDay.text!)+"."+String(currentMonthIndex)+"."+String(currentYear)
		print("Выбранная пользователем дата: \(bdate)")

		listener!.personSelectDate(date: bdate, resourceID: resourseID!)
		listener!.didPressDoctors()
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		cell?.backgroundColor = UIColor.clear
		let lbl = cell?.subviews[1] as! UILabel
		lbl.textColor = Style.activeCellLblColor
	}

}

// MARK: - UICollectionViewDataSource

extension CalendarViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		 return numOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth  - 1
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

extension CalendarViewController: UICollectionViewDelegateFlowLayout {

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

extension CalendarViewController: CalendarViewControllable {}
