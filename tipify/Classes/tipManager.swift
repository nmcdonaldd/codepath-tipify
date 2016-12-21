//
//  tipManager.swift
//  tipify
//
//  Created by Nick McDonald on 12/21/16.
//  Copyright © 2016 Nick McDonald. All rights reserved.
//

import UIKit

class tipManager: NSObject {
    
    static let sharedInstance: tipManager = tipManager()
    private var locationManager: tipLocationManager
    
    private override init() {
        locationManager = tipLocationManager.sharedInstance
    }

}
