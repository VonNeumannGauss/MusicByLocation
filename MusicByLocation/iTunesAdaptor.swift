//
//  iTunesAdaptor.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 20/05/2021.
//

import Foundation

class iTunesAdaptor {
    func getArtists(location: String, completion: @escaping ([Artist]?) -> Void) {
        print("Location: \(location)")
        guard let url = URL(string:"https://itunes.apple.com/search?term=\(location)&entity=musicArtist&limit=25")
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
        print("JSON: \(json.description)")
        
        do {
            let artistResponse = try decoder.decode(ArtistResponse.self, from: json)
            return artistResponse
        } catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            return nil
            
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            return nil
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            return nil
        }
    }
        
}
