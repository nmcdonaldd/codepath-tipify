//
//  tipLocationManager.swift
//  tipify
//
//  Created by Nick McDonald on 12/21/16.
//  Copyright © 2016 Nick McDonald. All rights reserved.
//

import UIKit
import CoreLocation

class tipLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance: tipLocationManager = tipLocationManager()
    
    private let locationManager = CLLocationManager()
    private var latestCountry: String!
    
    //This prevents others from using the default '()' initializer for this class.
    private override init() {
        super.init()
        
        setUpUserDefaults()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        NSLog("Starting to update user location")
        locationManager.startUpdatingLocation()
    }
	
	
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {[weak self] (placemarks, error) in
            // First, save battery by stop updating location.
            self?.locationManager.stopUpdatingLocation()
            
            if (error != nil) {
                //If error, could just set the location to last one in UserDefaults.
                self?.setLatestLocationOnError()
            }
            if (placemarks?.count)! > 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                self?.setLatestLocation(pm: pm)
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // First, stop updating location to save battery.
        self.locationManager.stopUpdatingLocation()
        
        // Want to ask UserDefaults to return the latest location, since failure.
        self.setLatestLocationOnError()
    }
    
    private func setLatestLocation(pm: CLPlacemark) {
        // Write this latest location to UserDefaults.
        let country = pm.country!
        self.latestCountry = country
        NSLog("Current country is %@", country)
        self.setLatestLocationAsDefault(location: country)
        
        // Send the notification post
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: tipLocationUpdatedKey), object: nil)
    }
    
    private func setLatestLocationOnError() {
        let country = self.getLatestLocationFromUserDefaults()
        NSLog("Error: setting current location to default - %@", country)
        self.latestCountry = country
    }
    
    
    // MARK: - UserDefaults methods
    
    private func setUpUserDefaults() {
        // If the default value hasn't been setup for location, set it up here.
        let prefs = UserDefaults.standard
        if !isKeyInUserDefaultsValid(key: tipLatestUserLocation) {
            prefs.set(tipDefaultUserLocation, forKey: tipLatestUserLocation)
            prefs.synchronize()
        }
    }
    
    private func isKeyInUserDefaultsValid(key: String) -> Bool {
        let prefs = UserDefaults.standard
        return prefs.value(forKey: tipLatestUserLocation) == nil ? false : true
    }
    
    private func setLatestLocationAsDefault(location: String) {
        let prefs = UserDefaults.standard
        NSLog("Setting %@ as latest user country location.", location)
        prefs.set(location, forKey: tipLatestUserLocation)
        prefs.synchronize()
    }
    
    private func getLatestLocationFromUserDefaults() -> String {
        let prefs = UserDefaults.standard
        return prefs.value(forKey: tipLatestUserLocation) as! String
    }
    
    
    // MARK: - Public methods
    
    func getLatestCountry() -> String {
        if self.latestCountry == nil {
            self.latestCountry = getLatestLocationFromUserDefaults()
        }
        NSLog("Returning latest country: %@", latestCountry)
        return self.latestCountry
    }
}
