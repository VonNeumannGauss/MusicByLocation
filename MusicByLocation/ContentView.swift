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
                List {
                    Text("Hello")
                    ForEach(state.artistsThemselves) { artist in
                        Text(artist.name)
                        Text(artist.genre)
                    }
                    Text(state.lastKnownLocation)
                        .padding()
                    /*
                    Text(state.artistNames)
                        .padding()
                     */
                }
                Spacer()
                Button("Find Music", action: {
                    state.findMusic()
                }).padding()
            }.onAppear(perform: {
                state.requestAccessToLocationData()
            }).navigationBarTitle("My Address")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
