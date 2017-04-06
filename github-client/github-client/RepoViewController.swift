//
//  RepoViewController.swift
//  github-client
//
//  Created by Mike Miksch on 4/4/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    var allRepos = [Repository]() {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    var displayRepos : [Repository]? {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        self.searchBar.delegate = self
        
        
        update()

        // Do any additional setup after loading the view.
    }
    
    func update() {
        GitHub.shared.getRepos { (repositories) in
            self.navigationItem.title = "My Repositories"
            guard let repositories = repositories else { return }
            self.allRepos = repositories
            let repoNib = UINib(nibName: "RepoCellNib", bundle: nil)
            
            self.repoTableView.register(repoNib, forCellReuseIdentifier: RepoCellNib.identifier)
            self.repoTableView.estimatedRowHeight = 150
            self.repoTableView.rowHeight = UITableViewAutomaticDimension
            
            self.repoTableView.dataSource = self

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
         if segue.identifier == RepoDetailViewController.identifier {
            if let selectedIndex = self.repoTableView.indexPathForSelectedRow?.row {
                let selectedRepo = self.allRepos[selectedIndex]
                
                if let destinationController = segue.destination as? RepoDetailViewController {
                
                destinationController.repo = selectedRepo
                }
               
//                    segue.destination.transitioningDelegate = self

            }
        }
    }

}


//MARK: UIViewControllerTransitioningDelegate
extension RepoViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTransition(duration: 1.0)
            
    }
}

//MARK: UITableViewDataSource
extension RepoViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRepos?.count ?? allRepos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCellNib.identifier, for: indexPath) as! RepoCellNib
        
        let repo = allRepos[indexPath.row]
        
        cell.repo = repo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: RepoDetailViewController.identifier, sender: nil)
    }

}


//MARK: UISearchBarDelegate
extension RepoViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
            
        }
        
        if let searchedText = searchBar.text {
            self.displayRepos = self.allRepos.filter({($0.name?.contains(searchedText))!})
        }
        
        if searchBar.text == "" {
            self.displayRepos = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.displayRepos = nil
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}
