//
//  StateController.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 17/05/2021.
//

import Foundation
//better to use this to separate out what classes do - so don't have locationHandler getting location and controlling state

class StateController: ObservableObject {
    @Published var lastKnownLocation: String = "" {
        didSet {
            getArtists(location: self.lastKnownLocation)
        }
    }
    @Published var artistNames: String = ""
   
    let locationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
        //getArtists()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorization()
    }
    
    func getArtists(location: String) {
        print("FDHSFDSHFDS")
        guard let url = URL(string:"https://itunes.apple.com/search?term=\(location)&entity=musicArtist")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJSON(json: data) {
                    //map from array of artists to array of strings
                    let names = response.results.map {
                        return $0.name
                    }
                    DispatchQueue.main.async {
                        self.artistNames = names.joined(separator: ", ")
                    }
                }
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
