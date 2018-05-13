//
//  AppDelegate.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 10/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        styleNavigationBar()
        return true
    }

}

extension AppDelegate {
    
    private func styleNavigationBar() {
        
        // Gives a transparent background to our app
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        
    }
}
