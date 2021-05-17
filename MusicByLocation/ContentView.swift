//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 14/05/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var state = StateController()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(state.lastKnownLocation)
                    .padding()
                Spacer()
                Button("Find Music", action: {
                    state.findMusic()
                }).padding()
            }.onAppear(perform: {
                state.requestAccessToLocationData()
                state.getArtists()
            }).navigationBarTitle("My Address")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
