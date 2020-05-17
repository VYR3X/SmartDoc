//
//  TabBarController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 14/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

	let mainNavigationViewController: UINavigationController?

//	init(navController: UINavigationController) {
//		mainNavigationViewController = navController
////		super.init()
//	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {

		let assembly = ReseptionFlowAssembly()

		let coordinator = assembly.makeCoordinator(in: mainNavigationViewController)

		let firstViewController = LaunchView()
		firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

		let doctorsViewController = assembly.makeDoctorsViewController(coordinator: coordinator)
		let polyclinicsViewController = assembly.makePolyclinicsViewController(coordinator: coordinator)

		let tabBarList = [firstViewController]

		viewControllers = tabBarList
	}
}
