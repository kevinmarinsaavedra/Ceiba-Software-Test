//
//  AddressCache.swift
//  ceibaSoftwareTest
//
//  Created by Kevin Marin on 19/9/21.
//

import RealmSwift

// MARK: - Address
final class AddressCache: Object {
    
    @Persisted var street: String?
    @Persisted var suite: String?
    @Persisted var city: String?
    @Persisted var zipcode: String?
    @Persisted var geo: GeoCache?

    convenience init(street: String?, suite: String?, city: String?, zipcode: String?, geo: GeoCache?) {
        self.init()
        
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}
