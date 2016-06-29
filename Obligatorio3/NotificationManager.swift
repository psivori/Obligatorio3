//
//  NotificationManager.swift
//  Obligatorio3
//
//  Created by Administrador on 29/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit

class NotificationManager:{

    
    
    func application(application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //send this device token to server
        
    }
    
    //Called if unable to register for APNS.
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        
        
        //println(error)
        
    }
    


}