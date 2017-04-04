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
        if let name = json["name"] as? String {
            self.name = name
            self.description = json["description"] as? String
            self.language = json["language"] as? String
        }
        
//        print(json)
        
        return nil
    }
    
}
