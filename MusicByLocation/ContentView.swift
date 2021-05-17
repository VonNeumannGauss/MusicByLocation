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
                Text(locationHandler.lastKnownLocation)
                    .padding()
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
