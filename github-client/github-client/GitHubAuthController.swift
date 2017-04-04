//
//  GitHubAuthController.swift
//  github-client
//
//  Created by Mike Miksch on 4/3/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    func disableButton() {
        if UserDefaults.standard.getAccessToken() != nil {
            print("You have an access token")
            
            loginButton.isEnabled = false
            loginButton.setTitle("YOU ARE ALREADY LOGGED IN", for: .normal)
            loginButton.backgroundColor = UIColor.red
        } 
    }
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        disableButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        disableButton()
    }
    
    @IBAction func printTokenPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
//        disableButton()
        let parameters = ["scope" : "email,user"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
    }

}
