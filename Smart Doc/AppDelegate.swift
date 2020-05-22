//
//  AppDelegate.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow()
		window?.makeKeyAndVisible()
		window?.backgroundColor = .orange

		let assembly = ReseptionFlowAssembly()
		//#warning("Нет лаунчера и открытие экранов через tab bar")

		let mainNavigationViewController = UINavigationController()
		let coordinator = assembly.makeCoordinator(in: mainNavigationViewController)
		//coordinator.routeToUserProfile()

		/// создаю таб бар
		let item = UITabBarItem(title: "Special", image: nil, selectedImage: nil)
		let doctorsViewController = assembly.makeSpecialitiesViewController(coordinator: coordinator)

		let item2 = UITabBarItem()
		item2.title = "History"
		let polyclinicsViewController = assembly.makeOperationHistoryViewController(coordinator: coordinator)

		let item3 = UITabBarItem()
		item3.title = "Doc"
		let userProfile = assembly.makeProfileViewController(coordinator: coordinator)

		let nc1 = coordinator.createNavigationContoller(vc: doctorsViewController)
		//nc1.title = "Specialities"
//		nc1.navigationBar.barStyle = .blackTranslucent
        let nc2 = UINavigationController(rootViewController: polyclinicsViewController)
        let nc3 = UINavigationController(rootViewController: userProfile)

		nc1.tabBarItem = item
		nc2.tabBarItem = item2
		nc3.tabBarItem = item3

		let tabBarController = UITabBarController()
		tabBarController.viewControllers = [nc1, nc2, nc3]

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

