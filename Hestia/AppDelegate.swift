//
//  AppDelegate.swift
//  Hestia
//
//  Created by Jonathan Long on 4/5/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    
    // MARK : UITabBarControllerDelegate 
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let splitViewController = viewController as? UISplitViewController {
            let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
            let masterNavigationController = splitViewController.viewControllers.first as! UINavigationController
            let masterViewController = masterNavigationController.topViewController as! PantryTableViewController
            masterViewController.companionViewController = navigationController.topViewController as? PantryItemDetailViewController
            navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        }
    }
    
    // MARK: - Application Delegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = self.window!.rootViewController as! UITabBarController
        tabBarController.delegate = self
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        print(url)
        
        return true
    }
}

