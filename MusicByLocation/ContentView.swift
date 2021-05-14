//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 14/05/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("Street: \(locationHandler.lastKnownLocationDictionary["thoroughfare"] ?? "N/A")")
                        .padding()
                    Text("District: \(locationHandler.lastKnownLocationDictionary["subLocality"] ?? "N/A")")
                        .padding()
                    Text("Town: \(locationHandler.lastKnownLocationDictionary["locality"] ?? "N/A")")
                        .padding()
                    Text("Postal Code: \(locationHandler.lastKnownLocationDictionary["postalCode"] ?? "N/A")")
                        .padding()
                    Text("Country: \(locationHandler.lastKnownLocationDictionary["country"] ?? "N/A")")
                        .padding()
                }
                Spacer()
                Button("Find Music", action: {
                    locationHandler.requestLocation()
                }).padding()
            }.onAppear(perform: {
                locationHandler.requestAuthorization()
            }).navigationBarTitle("My Address")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
