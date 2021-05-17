//
//  CLPlacemark.swift
//  MusicByLocation
//
//  Created by Marinov, Zachary (Coll) on 17/05/2021.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func getLocationBreakdown() -> String {
        return
            """
            Street: \(self.thoroughfare ?? "N/A")
            District: \(self.subLocality ?? "N/A")
            Town: \(self.locality ?? "N/A")
            Postal Code: \(self.postalCode ?? "N/A")
            Country: \(self.country ?? "N/A")
            """
    }
}



