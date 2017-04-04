//
//  GitHubAuthController.swift
//  github-client
//
//  Created by Mike Miksch on 4/3/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if (UserDefaults.standard.value(forKey: "access_token") != nil) {
//            print("You have an access token")
//
//            loginButton.isEnabled = false
//            loginButton.setTitle("YOU ARE ALREADY LOGGED IN", for: .normal)
//            loginButton.backgroundColor = UIColor.red
//        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func printTokenPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if (UserDefaults.standard.value(forKey: "access_token") != nil) {
            print("You have an access token")
            
            loginButton.isEnabled = false
            loginButton.setTitle("YOU ARE ALREADY LOGGED IN", for: .normal)
            loginButton.backgroundColor = UIColor.red
        } else {

        let parameters = ["scope" : "email,user"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        }
    }

}
