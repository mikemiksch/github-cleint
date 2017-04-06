//
//  Repository.swift
//  github-client
//
//  Created by Mike Miksch on 4/4/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class Repository {
    
    let name : String?
    let description : String?
    let language : String?
    let stars : Int?
    let forked : Bool?
    let creation : String?
    
    init?(json: [String : Any]) {
        self.name = json["name"] as? String
        self.description = json["description"] as? String
        self.language = json["language"] as? String
        self.creation = json["created_at"] as? String
        self.stars = json["stargazers_count"] as? Int
        self.forked = json["forked"] as? Bool
        
    }
    
    
    
}
