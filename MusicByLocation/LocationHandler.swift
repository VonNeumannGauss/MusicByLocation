//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 14/05/2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    @Published var lastKnownLocationDictionary: [String:String] = [:]
    
    override init() {
        super.init()
        //set up delegate
        manager.delegate = self
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("LOcations", locations)
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "Could not perform lookup of location from coordinate information"
                    self.lastKnownLocationDictionary["error"] = "Could not perform lookup of location from coordinate information"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        //this syntax with the ?? is called nil coalescing. It says if this is nil, assign the value after the ??
                        self.lastKnownLocation = firstPlacemark.thoroughfare ?? "Couldn't find thoroughfare"
                        
                        self.lastKnownLocationDictionary["thoroughfare"] = firstPlacemark.thoroughfare ?? "Couldn't find thoroughfare"
                        self.lastKnownLocationDictionary["subLocality"] = firstPlacemark.subLocality ?? "Couldn't find subLocality"
                        self.lastKnownLocationDictionary["locality"] = firstPlacemark.locality ?? "Couldn't find locality"
                        self.lastKnownLocationDictionary["postalCode"] = firstPlacemark.postalCode ?? "Couldn't find postal code"
                        self.lastKnownLocationDictionary["country"] = firstPlacemark.country ?? "Couldn't find country"
                    }
                }
            })
        }
        print("Dictionary", self.lastKnownLocationDictionary)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "Error when finding location"
        lastKnownLocationDictionary["error"] = "Error when finding location"
    }
    
}
