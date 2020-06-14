//
//  AppDelegate.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		// TO:DO - разабраться что происходит с отображением контроллеров
		// как устанавливабются items
		// почему push первого контроллера с косяками
		// перенести найтроку навигационного контроллера в отдельный класс ( сделать кастомнвый контроллер)
		// почистить appdelegate
		// tabbar установить иконки и вообще сделать настройку

		window = UIWindow()
		window?.makeKeyAndVisible()
		window?.backgroundColor = UIColor(red: 125/255, green: 0/255, blue: 235/255, alpha: 1)

		let assembly = ReseptionFlowAssembly()
		//#warning("Нет лаунчера и открытие экранов через tab bar")

		let mainNavigationViewController = UINavigationController()
		let coordinator = assembly.makeCoordinator(in: mainNavigationViewController)

		/// создаю таб бар
		let item = UITabBarItem(title: "История", image: nil, selectedImage: nil)
		//et specialitiesViewController = assembly.makeSpecialitiesViewController(coordinator: coordinator)
		let mainscreen = assembly.makeMainViewController(coordinator: coordinator)

		let item2 = UITabBarItem()
		item2.title = "Профиль"
		let historyViewController = assembly.makeOperationHistoryViewController(coordinator: coordinator)

		let item3 = UITabBarItem()
		item3.title = "Профиль"
		let userProfileViewController = assembly.makeProfileViewController(coordinator: coordinator)

        let nc1 = UINavigationController(rootViewController: historyViewController)
        let nc2 = UINavigationController(rootViewController: userProfileViewController)
		let nc3 = coordinator.createNavigationContoller(vc: mainscreen)

		nc1.tabBarItem = item
		nc2.tabBarItem = item2
		nc3.tabBarItem = item3

		let tabBarController = UITabBarController()
		tabBarController.viewControllers = [nc3, nc1, nc2]

		//coordinator.startFlow()

		window?.rootViewController = tabBarController
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}

