//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 14/05/2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    //this is not a strong reference - allows this reference to state to be taken out of memory
    weak var stateController: StateController?
    
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
                    self.stateController?.lastKnownLocation = "Could not perform lookup of location from coordinate information"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        //this syntax with the ?? is called nil coalescing. It says if this is nil, assign the value after the ??
                        self.stateController?.lastKnownLocation = firstPlacemark.locality ?? "N/A"
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.stateController?.lastKnownLocation = "Error when finding location"
    }
    
}
