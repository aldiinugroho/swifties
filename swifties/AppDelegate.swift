//
//  AppDelegate.swift
//  swifties
//
//  Created by aldinugroho on 04/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let appColor = UIColor(named: "softpink")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = appColor
        let view = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = view
        return true
    }
}

