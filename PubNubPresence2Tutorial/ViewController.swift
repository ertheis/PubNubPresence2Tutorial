//
//  ViewController.swift
//  PubNubPresence2Tutorial
//
//  Created by Eric Theis on 7/8/14.
//  Copyright (c) 2014 PubNub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        var myConfig = PNConfiguration(forOrigin: "pubsub.pubnub.com", publishKey: "demo", subscribeKey: "demo", secretKey: nil)
        var uuid = "Fred_Rerun_Stubbs"
        PubNub.setClientIdentifier(uuid)
        PubNub.setConfiguration(myConfig)
        PubNub.connect()
        
        let myChannel = PNChannel.channelWithName("demo", shouldObservePresence: false) as PNChannel
        
        PNObservationCenter.defaultCenter().addClientConnectionStateObserver(self) { (origin: String!, connected: Bool!, error: PNError!) in
            if connected {
                println("OBSERVER: Successful Connection!");
                
                PubNub.subscribeOnChannel(myChannel)
                
            } else {
                println("OBSERVER: \(error.localizedDescription), Connection Failed!");
            }
        }
        
        PNObservationCenter.defaultCenter().addClientChannelSubscriptionStateObserver(self) { (state: PNSubscriptionProcessState, channels: [AnyObject]!, error: PNError!) in
            switch state {
            case PNSubscriptionProcessState.SubscribedState:
                var enabled = PubNub.isPresenceObservationEnabledForChannel(myChannel)
                println("OBSERVER: Subscribed to Channel: \(channels[0]), Presence enabled: \(enabled)")
                if !enabled {
                    PubNub.enablePresenceObservationForChannel(myChannel)
                }
            case PNSubscriptionProcessState.NotSubscribedState:
                println("OBSERVER: Not subscribed to Channel: \(channels[0]), Error: \(error)")
            case PNSubscriptionProcessState.WillRestoreState:
                println("OBSERVER: Will re-subscribe to Channel: \(channels[0])")
            case PNSubscriptionProcessState.RestoredState:
                println("OBSERVER: Re-subscribed to Channel: \(channels[0])")
            default:
                println("OBSERVER: Something went wrong :(")
            }
        }
        
        PNObservationCenter.defaultCenter().addClientPresenceEnablingObserver(self) { (channels: [AnyObject]!, error: PNError!) in
            println("OBSERVER: Presence enabled on Channel: \(channels)")
        }
        
        PNObservationCenter.defaultCenter().addPresenceEventObserver(self) { (event: PNPresenceEvent!) in
            switch event.type {
            case PNPresenceEventType.Join:
                PubNub.sendMessage("\(uuid) says: What's happening?!", toChannel: myChannel)
            case PNPresenceEventType.Leave:
                PubNub.sendMessage("\(uuid) says: Catch you on the flip side!", toChannel: myChannel)
                PubNub.unsubscribeFromChannel(myChannel)
            case PNPresenceEventType.Timeout:
                PubNub.sendMessage("\(uuid) says: Too bad!", toChannel: myChannel)
            default:
                println("something went wrong in your presence observer callback")
            }
            
            switch event.occupancy {
            case 1:
                PubNub.sendMessage("\(uuid) says: It's a ghost town.", toChannel: myChannel)
            case 2:
                PubNub.sendMessage("\(uuid) says: It takes two to make a thing go right.", toChannel: myChannel)
            case 3:
                PubNub.sendMessage("\(uuid) says: Three's a party!", toChannel: myChannel)
            default:
                PubNub.sendMessage("\(uuid) says: Hellooooo out there!", toChannel: myChannel)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

