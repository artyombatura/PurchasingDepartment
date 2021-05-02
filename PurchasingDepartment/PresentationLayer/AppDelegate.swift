//
//  AppDelegate.swift
//  PurchasingDepartment
//
//  Created by Artsiom Batura on 26/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start(true)
        
        return true
    }
}

