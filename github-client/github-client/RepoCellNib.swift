//
//  RepoCellNib.swift
//  github-client
//
//  Created by Mike Miksch on 4/4/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class RepoCellNib: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    
    var repo : Repository! {
        didSet {
            self.repoName.text = repo.name
        }
    }

    
}
