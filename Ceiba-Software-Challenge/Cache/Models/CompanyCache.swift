//
//  CompanyCache.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 19/9/21.
//

import RealmSwift

// MARK: - CompanyCache
final class CompanyCache: Object {
    
    @Persisted var name: String?
    @Persisted var catchPhrase: String?
    @Persisted var bs: String?
    
    convenience init(name: String?, catchPhrase: String?, bs: String?) {
        self.init()
        
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
