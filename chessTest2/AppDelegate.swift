//
//  AppDelegate.swift
//  chessTest2
//
//  Created by Saltanat Aimakhanova on 7/11/16.
//  Copyright © 2016 saltaim. All rights reserved.
//

import UIKit
import CoreData
import ENSwiftSideMenu
import Fabric
import TwitterKit
import Crashlytics
import OAuthSwift
import SwiftHEXColors


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let APP_ID = "E0ECF815-DD6D-9EEC-FF59-13E873A2BB00"
    let SECRET_KEY = "F6B4148C-4ECD-784F-FF95-156765E5F100"
    let VERSION_NUM = "v1"
    var backendless = Backendless.sharedInstance()

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        Fabric.with([Crashlytics.self, Twitter.self])
        var edge: Float!
        if UIScreen.mainScreen().bounds.width > UIScreen.mainScreen().bounds.height{
            edge = Float((UIScreen.mainScreen().bounds.height-50)/8)
        }else{
            edge = Float((UIScreen.mainScreen().bounds.width-50)/8)
        }
        Cell.SWidth = edge
        Cell.Sheight = edge
        if backendless.userService.currentUser == nil{

            //Cell.SWidth = Float((UIScreen.mainScreen().bounds.width-50)/8)
            //Cell.Sheight = Float(((UIScreen.mainScreen().bounds.height-210))/8)
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
            let bar = window?.rootViewController as! UINavigationController
            bar.navigationBar.backgroundColor = UIColor(red: 1/255, green: 152/255, blue: 215/255, alpha: 1)
            window?.makeKeyAndVisible()
        }else{
           // Cell.SWidth = Float((UIScreen.mainScreen().bounds.width-50)/8)
           // Cell.Sheight = Float(((UIScreen.mainScreen().bounds.height-210))/8)
            let less = LessonsViewController()
            let nav1 = SideNavigationViewController()
            nav1.viewControllers = [less]

            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window?.rootViewController = nav1
            nav1.navigationBar.backgroundColor = UIColor.blueColor()
            window?.makeKeyAndVisible()
        }
        return true

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "saltaim.chessTest2" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("chessTest2", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

