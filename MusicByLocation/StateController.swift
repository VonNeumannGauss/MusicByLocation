//
//  StateController.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 17/05/2021.
//

import Foundation
//better to use this to separate out what classes do - so don't have locationHandler getting location and controlling state

class StateController: ObservableObject {
    
    let locationHandler = LocationHandler()
    let ITunesAdaptor = iTunesAdaptor()
    
    @Published var artistNames: String = ""
    @Published var lastKnownLocation: String = "" {
        didSet {
            //trailing closure syntax
            //a REFERENCE to updateArtistsByLocation is passed in, not the function itself
            ITunesAdaptor.getArtists(location: self.lastKnownLocation, completion: updateArtistsByLocation)
        }
    }
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func updateArtistsByLocation(artists: [Artist]?) {
        let names = artists?.map {
            return $0.name
        }
        DispatchQueue.main.async {
            self.artistNames = names?.joined(separator: ", ") ?? "Error finding artists near you"
        }
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorization()
    }
    
}
