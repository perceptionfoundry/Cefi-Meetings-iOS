//
//  AppDelegate.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
//    var apiBaseURL = "https://www.ceficrm.com/api/"
   var apiBaseURL =  "https://testingnodejss.herokuapp.com/api/"
    
    var userID = ""
    var window: UIWindow?
    var startTime : Date?

    let GoogleAPIKey = "AIzaSyAdcVyixBYtthIiqtpZrSofxxutGgIq8Os"
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true

        GMSServices.provideAPIKey(GoogleAPIKey)
        GMSPlacesClient.provideAPIKey(GoogleAPIKey)
        checkUserLogin()
        return true
    }
    
    func checkUserLogin(){
        // check user default value
        
        if (UserDefaults.standard.bool(forKey: "Auth") == true){
        
            
        userID = UserDefaults.standard.string(forKey: "UserID")!
        
            
            
            let storybord = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarController = storybord.instantiateViewController(withIdentifier: "Dashboard") as! UITabBarController
        
        let homeNavigationController = storybord.instantiateViewController(withIdentifier: "Dashboard_Nav") as! UINavigationController
        let meetingNavigationController = storybord.instantiateViewController(withIdentifier: "Meeting_Nav") as! UINavigationController
        let contractNavigationController = storybord.instantiateViewController(withIdentifier: "Contract_Nav") as! UINavigationController
        let contactNavigationController = storybord.instantiateViewController(withIdentifier: "Contact_Nav") as! UINavigationController
        let pendingNavigationController = storybord.instantiateViewController(withIdentifier: "Pending_Nav") as! UINavigationController

        
        tabBarController.viewControllers = [homeNavigationController,meetingNavigationController,contractNavigationController,contactNavigationController,pendingNavigationController]
        
        self.window?.rootViewController = tabBarController
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
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

