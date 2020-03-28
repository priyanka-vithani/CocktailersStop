//
//  AppDelegate.swift
//  CocktailersStop
//
//  Created by ELaunch on 31/01/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
     var appNavigation:UINavigationController?

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        initVC()
        return true
    }
    func initVC(){
       
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: loadVC(strStoryboardId: "Main", strVCId: "HomeVC"))
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = true
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
        APP_DELEGATE.window?.makeKeyAndVisible()
        
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       hideHUD()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        var preferredStatusBarStyle: UIStatusBarStyle{
            return UIStatusBarStyle.lightContent
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}


