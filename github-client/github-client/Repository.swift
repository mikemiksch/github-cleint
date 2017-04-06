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
    
    let repoUrlString : String
    
    init?(json: [String : Any]) {
        self.name = json["name"] as? String ?? "None"
        self.description = json["description"] as? String ?? "None"
        self.language = json["language"] as? String ?? "Unknown Language"
        self.creation = json["created_at"] as? String ?? "Unknown Date"
        self.stars = json["stargazers_count"] as? Int ?? 0
        self.forked = json["forked"] as? Bool ?? nil
        
        self.repoUrlString = json["html_url"] as? String ?? "https://www.github.com"
        
    }
    
    
    
}
