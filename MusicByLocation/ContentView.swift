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
                Form {
                    //Text("Hello")
                    ForEach(state.artistsThemselves, id: \.self.id) { artist in
                        LazyVStack {
                            Link("Artist Name: \(artist.name)", destination:  artist.url)
                            Text("Genre: \(artist.genre)")
                        }
                    }
                    /*Text(state.lastKnownLocation)
                        .padding()
                    */
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
            }).navigationBarTitle("Music Near Me")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
