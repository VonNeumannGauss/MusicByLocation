//
//  Artist.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 17/05/2021.
//

import Foundation

struct Artist: Codable {
    var name: String
    var genre: String
    
    //custom decoding can be done by adding CodingKeys. This is needed when the variables names here and the actual JSON variable names differ, so this tells Swift what to assign where. 
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
        case genre = "primaryGenreName"
    }
}
