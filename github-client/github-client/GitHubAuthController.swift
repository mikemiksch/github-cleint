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
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func printTokenPressed(_ sender: Any) {
        let token = UserDefaults.standard.getAccessToken()
        print(token)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let parameters = ["scope" : "email,user,repo"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
    }

    func disableButton() {
        if UserDefaults.standard.getAccessToken() != nil {
            print("You have an access token")
            
            loginButton.isEnabled = false
            loginButton.setTitle("YOU ARE ALREADY LOGGED IN", for: .normal)
            loginButton.backgroundColor = UIColor.red
        }
    }
    
    func dismissAuthController() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
}
