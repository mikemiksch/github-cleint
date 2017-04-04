//
//  GitHub.swift
//  github-client
//
//  Created by Mike Miksch on 4/3/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

typealias GitHubOAuthCompletion = (Bool) -> ()
typealias FetchReposCompletion = ([Repository]?) -> ()

enum GitHubAuthError : Error {
    case extractingCode
}

enum SaveOptions {
    case userDefaults
}

let kOAuthBaseURLString = "https://github.com/login/oauth/"

class GitHub {
    
    private var session: URLSession
    private var components: URLComponents
    
    static let shared = GitHub()
    
    private init() {
        
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        
        self.components.scheme = "https"
        self.components.host = "api.github.com"
        
        if let token = UserDefaults.standard.getAccessToken() {
            let queryItem = URLQueryItem(name: "access_token", value: token)
            self.components.queryItems = [queryItem]
        }
    }

    func oAuthRequestWith(parameters: [String : String]) {
        var parametersString = ""
        
        for (key, value) in parameters {
            parametersString += "&\(key)=\(value)"
        }
        
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubClientID)\(parametersString)") {
            print(requestURL.absoluteString)

            UIApplication.shared.open(requestURL)
        }
        
    }
    
    func getCodeFrom(url : URL) throws -> String {
        guard let code = url.absoluteString.components(separatedBy: "=").last else { throw GitHubAuthError.extractingCode
        }
        
        return code
    }
    
    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion) {
        
        func complete(success: Bool) {
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        
        do {
            let code = try self.getCodeFrom(url: url)
            
            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(gitHubClientID)&client_secret=\(gitHubClientSecret)&code=\(code)"
            
            if let requestURL = URL(string: requestString) {
                
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                    if error != nil { complete(success: false) }
                    
                    guard let data = data else { complete(success: false); return }
                    
                    if let dataString = String(data: data, encoding: .utf8), let token = self.accessTokenFrom(dataString) {
                        print("accessTokenFrom: \(token)")
                        UserDefaults.standard.save(accessToken: token)

                        complete(success: true)
                        
                    }
                    
                 }).resume()
            }
            
        } catch {
            print(error)
            complete(success: false)
        }
        
    }
    
    func accessTokenFrom(_ string: String) -> String? {
        if string.contains("access_token") {
            let components = string.components(separatedBy: "&")
            
            for component in components {
                if component.contains("access_token") {
                    let token = component.components(separatedBy: "=").last
                    return token
                }
            }
        }
        return nil
    }
    
    func getRepos(completion: @escaping FetchReposCompletion) {
        
        func returnToMain(results: [Repository]?) {
            OperationQueue.main.addOperation {
                completion(results)
            }
        }
        
        self.components.path = "/user/repos"
        
        guard let url = self.components.url else { returnToMain(results: nil); return }
        
        self.session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                returnToMain(results: nil)
                return
            }
            
            if let data = data {
                
//                var repositories = [Repository]()

                do {
                    
                    if let rootJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] {
                        print(rootJSON)
                        
                        for repositoryJSON in rootJSON {
                            if let repo = Repository(json: repositoryJSON) {
                                RepoViewController.repositories.append(repo)
                                print(repo.name, repo.description, repo.language)
                            }
                        }
                        print(RepoViewController.repositories.count)
                        returnToMain(results: RepoViewController.repositories)
                        
                    }
                    
                } catch {
                    
                }
                
            }
            
        }.resume()
        
    }

}
