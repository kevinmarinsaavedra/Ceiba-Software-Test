//
//  RealmDataBase.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 19/9/21.
//

import RealmSwift

protocol LocalDatabaseManager {
    func getUsers() -> [User]
    func setUsers(users: [User])
}

final class RealmDataBase: LocalDatabaseManager {
    
    var realm: Realm!
    
    init(identifier: String = "CeibaLocalDB") {
        let configuration = Realm.Configuration(inMemoryIdentifier: identifier)
        realm = try! Realm(configuration: configuration)
    }
        
    func getUsers() -> [User] {
        // Access all UserCache in the realm
        
        guard let usersCache = realm?.objects(UserCache.self) else {
            return []
        }
        
        let users = usersCache.map { (user) -> User in
            
            let geo = Geo(lat: user.address?.geo?.lat, lng: user.address?.geo?.lng)
            
            let address = Address(street: user.address?.street,
                                            suite: user.address?.suite,
                                            city: user.address?.city,
                                            zipcode: user.address?.zipcode,
                                            geo: geo)
            
            let company = Company(name: user.company?.name,
                                            catchPhrase: user.company?.catchPhrase,
                                            bs: user.company?.bs)
            
            return User(id: user.id,
                        name: user.name,
                        username: user.username,
                        email: user.email,
                        address: address,
                        phone: user.phone,
                        website: user.website,
                        company: company)
        }
        
        return Array.init(users)
    }
    
    func setUsers(users: [User]) {
        
        resetDB()
        
        let users = users.map { (user) -> UserCache in
            
            let geoCache = GeoCache(lat: user.address?.geo?.lat, lng: user.address?.geo?.lng)
            
            let addressCache = AddressCache(street: user.address?.street,
                                            suite: user.address?.suite,
                                            city: user.address?.city,
                                            zipcode: user.address?.zipcode,
                                            geo: geoCache)
            
            let companyCache = CompanyCache(name: user.company?.name,
                                            catchPhrase: user.company?.catchPhrase,
                                            bs: user.company?.bs)
            
            return UserCache(id: user.id,
                             name: user.name,
                             username: user.username,
                             email: user.email,
                             address: addressCache,
                             phone: user.phone,
                             website: user.website,
                             company: companyCache)
        }
        
        do {
            try realm?.write {
                realm?.add(users)
            }
        } catch {
            return
        }

    }
    
    func resetDB(){
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            return
        }
    }
}
