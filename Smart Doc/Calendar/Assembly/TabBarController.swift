//
//  TabBarController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 14/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

	let mainNavigationViewController: UINavigationController? = nil

//	init(navController: UINavigationController) {
//		mainNavigationViewController = navController
////		super.init()
//	}

//	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {

		let assembly = ReseptionFlowAssembly()

		let coordinator = assembly.makeCoordinator(in: mainNavigationViewController)

		//let firstViewController = LaunchView()
		//firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

		let doctorsViewController = assembly.makeDoctorsViewController(coordinator: coordinator)
		let polyclinicsViewController = assembly.makePolyclinicsViewController(coordinator: coordinator)
		let userProfile = assembly.makeProfileViewController(coordinator: coordinator)

		//let tabBarList = [firstViewController]

		let tabBarController = UITabBarController()
		tabBarController.viewControllers = [doctorsViewController,
											polyclinicsViewController,
											userProfile]

		// Use the view controller reference to select the second tab
		//tabBarController.selectedViewController = polyclinicsViewController

		// Use the array index to select the third tab
		tabBarController.selectedIndex = 1

		//viewControllers = tabBarList
	}
}
