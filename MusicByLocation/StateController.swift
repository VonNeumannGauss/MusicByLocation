//
//  StateController.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 17/05/2021.
//

import Foundation
//better to use this to separate out what classes do - so don't have locationHandler getting location and controlling state

class StateController: ObservableObject {
    @Published var lastKnownLocation: String = ""
    let locationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorization()
    }
}
