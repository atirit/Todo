//
//  AppDelegate.swift
//  todo
//
//  Created by Aydin Tiritoglu on 5/22/16.
//  Copyright © 2018 Aydin Tiritoglu. All rights reserved.
//

import UIKit

import Foundation

var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
let fileURL = documentsDirectory.appendingPathComponent("file.txt")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            documentsDirectory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first!)
        #endif
        
        if ((fileURL as NSURL).checkResourceIsReachableAndReturnError(nil)) {
            print("file exists")
        } else {
            print("file doesn't exist")
            try? Data().write(to: fileURL,options: [.atomic])
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let cocoaArray : NSArray = listOfTasks as NSArray
        cocoaArray.write(to: fileURL, atomically:true)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let cocoaArray : NSArray = listOfTasks as NSArray
        cocoaArray.write(to: fileURL, atomically:true)
    }


}

