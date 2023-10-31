//
//  UserCache.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 19/9/21.
//

import RealmSwift

// MARK: - UserCache
final class UserCache: Object {
    
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var username: String?
    @Persisted var email: String?
    @Persisted var address: AddressCache?
    @Persisted var phone: String?
    @Persisted var website: String?
    @Persisted var company: CompanyCache?
    
    convenience init(id: Int?, name: String?, username: String?, email: String?, address: AddressCache, phone: String?, website: String?, company: CompanyCache) {
        self.init()
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
    }
}
