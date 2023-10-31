//
//  GeoCache.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 19/9/21.
//

import RealmSwift

// MARK: - GeoCache
final class GeoCache: Object {
    
    @Persisted var lat: String?
    @Persisted var lng: String?
    
    convenience init(lat: String?, lng: String?) {
        self.init()
        
        self.lat = lat
        self.lng = lng
    }
}
