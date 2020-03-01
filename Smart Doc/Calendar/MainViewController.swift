//
//  MainViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Выбор темы приложения
enum MyTheme {
	case light
	case dark
}

/// Главный экран приложения
final class MainViewController: UIViewController {

	private var theme = MyTheme.dark

	private let calenderView: CalenderView = {
		let v = CalenderView(theme: MyTheme.dark)
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		calenderView.daysCollectionView.collectionViewLayout.invalidateLayout()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "My Calender"
		self.navigationController?.navigationBar.isTranslucent = false
		self.view.backgroundColor = Style.bgColor

		let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
		self.navigationItem.rightBarButtonItem = rightBarBtn

		setupView()
	}

	private func setupView() {

		view.addSubview(calenderView)

		NSLayoutConstraint.activate([
			calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
			calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
			calenderView.heightAnchor.constraint(equalToConstant: 365)
		])
	}

	@objc func rightBarBtnAction(sender: UIBarButtonItem) {
		if theme == .dark {
			sender.title = "Dark"
			theme = .light
			Style.themeLight()
		} else {
			sender.title = "Light"
			theme = .dark
			Style.themeDark()
		}
		self.view.backgroundColor = Style.bgColor
		calenderView.changeTheme()
	}
}
