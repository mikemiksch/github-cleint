//
//  RepoViewController.swift
//  github-client
//
//  Created by Mike Miksch on 4/4/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        update()

        // Do any additional setup after loading the view.
    }
    
    func update() {
        print("Update repo controller here!")
        GitHub.shared.getRepos { (repositories) in
            //update tableView
        }
    }

}


//MARK: UITableViewDataSource
//extension RepoViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//}
//
////MARK: UITableViewDelegate
//extension RepoViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//}
