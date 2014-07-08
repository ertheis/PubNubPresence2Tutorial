//
//  AppDelegate.swift
//  PubNubPresence2Tutorial
//
//  Created by Eric Theis on 7/8/14.
//  Copyright (c) 2014 PubNub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        PubNub.setDelegate(self)
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
    }
    
    func pubnubClient(client: PubNub!, didConnectToOrigin origin: String!) {
        println("DELEGATE: Connected to origin \(origin)")
    }
    
    func pubnubClient(client: PubNub!, didEnablePresenceObservationOnChannels channels: [AnyObject]!) {
        println("DELEGATE: Presence observation enabled.")
    }
    
    func pubnubClient(client: PubNub!, didReceivePresenceEvent event: PNPresenceEvent) {
        println("DELEGATE: Received Presence event: \(event)")
    }
    
    func pubnubClient(client: PubNub!, didUnsubscribeOnChannels channels: [AnyObject]!) {
        println("DELEGATE: Unsubscribed frome channel: \(channels)")
    }
    
    func pubnubClient(client: PubNub!, didDisablePresenceObservationOnChannels channels: [AnyObject]!) {
        println("DELEGATE: Disabled Presence observation.")
    }
}