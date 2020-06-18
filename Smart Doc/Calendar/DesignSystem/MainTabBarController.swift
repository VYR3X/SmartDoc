//
//  MainTabBarController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 18/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Таб Бар контроллер
final class MainTabBarController: UITabBarController {

	private var assembly: ReseptionFlowAssembly = ReseptionFlowAssembly()

	private var mainNavigatioController: UINavigationController = UINavigationController()

	private var coordinator: Coordinator?

	init(assembly: ReseptionFlowAssembly,
		 mainNavigatioController: UINavigationController) {
		super.init(nibName: nil, bundle: nil)
		self.assembly = assembly
		self.mainNavigatioController = mainNavigatioController
		coordinator = assembly.makeCoordinator(in: mainNavigatioController)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		
		coordinator = assembly.makeCoordinator(in: mainNavigatioController)

		let mainscreen = assembly.makeMainViewController(coordinator: coordinator!)
		let historyViewController = assembly.makeOperationHistoryViewController(coordinator: coordinator!)
		let userProfileViewController = assembly.makeProfileViewController(coordinator: coordinator!)

		let nav1 = mainscreen //generateNavigationController(vc: mainscreen!)
		let nav2 = historyViewController //generateNavigationController(vc: historyViewController!)
		let nav3 = userProfileViewController //generateNavigationController(vc: userProfileViewController!)

		viewControllers = [nav1, nav2, nav3]
	}

	private func generateNavigationController(vc: UIViewController) -> UINavigationController {
		vc.navigationItem.title = "NavBarTitle"
		let navController = UINavigationController(rootViewController: vc)
		navController.title = "TabBarTitle"
		return navController
	}
}
