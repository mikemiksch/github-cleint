//
//  Repository.swift
//  github-client
//
//  Created by Mike Miksch on 4/4/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class Repository {
    
    let name : String
    let description : String?
    let language : String?
    
    init?(json: [String : Any]) {
        guard let name = json["name"] as? String else { return nil }
            self.name = name
        guard let description = json["description"] as? String else { return nil }
            self.description = description
        guard let language = json["language"] as? String else { return nil }
        self.language = language
        }
        
//        print(json)
    
}
