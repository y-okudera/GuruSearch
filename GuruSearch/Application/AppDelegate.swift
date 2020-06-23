//
//  AppDelegate.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/20.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        self.firstView(viewController: AreaListRouter.assembleModules(), includeNavigationController: true)
        
        return true
    }
}
