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
    
    func getArtists() {
        print("FDHSFDSHFDS")
        guard let url = URL(string:"https://itunes.apple.com/search?term=Lionel%20Richie&entity=musicArtist")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("DFDSFD")
            if let data = data {
                print("EHLLO")
                print(String(decoding: data, as: UTF8.self))
            }
            
        }.resume()
    }
    
    func parseJSON(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        do {
            let artistResponse = try decoder.decode(ArtistResponse.self, from: json)
            return artistResponse
        } catch {
            print("Error decoding JSON")
            return nil
        }
        
    }
}
