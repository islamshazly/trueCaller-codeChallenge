//
//  AppDelegate.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        start()
        return true
    }
    
    func start() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: MainViewController.self)
        let viewModel = MainViewModel(service: MainServiceImpl(apiClient: ApiClientImpl()))
        mainViewController?.viewModel = viewModel
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
}

