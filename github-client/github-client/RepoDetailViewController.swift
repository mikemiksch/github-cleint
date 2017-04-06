//
//  RepoDetailViewController.swift
//  github-client
//
//  Created by Mike Miksch on 4/5/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import SafariServices

class RepoDetailViewController: UIViewController {
    
    var repo : Repository!

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoLanguageLabel: UILabel!
    @IBOutlet weak var repoCreationDateLabel: UILabel!
    @IBOutlet weak var repoRatingLabel: UILabel!
    @IBOutlet weak var repoForkedStatusLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func moreDetailsPressed(_ sender: Any) {
        guard let repo = repo else { return }
        presentSafariViewControllerWith(urlString: repo.repoUrlString)
//        presentWebViewControllerWith(urlString: repo.repoUrlString)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.repoNameLabel.text = self.repo.name
        self.repoLanguageLabel.text = self.repo.language
        self.repoCreationDateLabel.text = self.repo.creation
        self.repoDescriptionLabel.text = self.repo.description
        guard let stars = self.repo.stars else { return }
        self.repoRatingLabel.text = "\(stars) star ratings"
        if self.repo.forked == false {
            self.repoForkedStatusLabel.text = "Unforked"
        } else {
            self.repoForkedStatusLabel.text = "Forked"
        }
        
        let date = self.repo.creation
        self.repoCreationDateLabel.text = self.getDate(date!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getDate(_ string: String) -> String? {
        let components = string.components(separatedBy: "T")
        for component in components {
            if component.contains("Z") {
                let date = components.first
                return date
            }
        }
        return nil
    }
    
    func presentSafariViewControllerWith(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariController = SFSafariViewController(url: url)
        self.present(safariController, animated: true, completion: nil)
    }
    
    func presentWebViewControllerWith(urlString: String) {
        
        let webController = WebViewController()
        webController.url = urlString
        
        self.present(webController, animated: true, completion: nil)
        
    }
    
}


//MARK: UIViewControllerTransitioningDelegate
extension RepoDetailViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition()
    }
    
}
