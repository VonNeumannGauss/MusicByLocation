//
//  iTunesAdaptor.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 20/05/2021.
//

import Foundation

class iTunesAdaptor {
    func getArtists(location: String, completion: @escaping ([Artist]?) -> Void) {
        print("FDHSFDSHFDS")
        guard let url = URL(string:"https://itunes.apple.com/search?term=\(location)&entity=musicArtist")
        else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJSON(json: data) {
                    completion(response.results)
                } else {
                    completion(nil)
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
