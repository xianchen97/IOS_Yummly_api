//
//  ViewController.swift
//  YummlyAPI
//
//  Created by Xian Chen Ruan on 2018-11-23.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    @IBOutlet weak var RecipeTable: UITableView!
    var results:RecipeMatches = RecipeMatches()
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        getRecipeSearchResults(with: "apple");
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(results.searchResults.count)
        return results.searchResults.count
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getRecipeSearchResults(with: searchBar.text!)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let matches = results.searchResults[indexPath.row].imageUrlsBySize
        let url = matches.first?.value
        cell.imageView?.image = ImageFromUrl().getDetailImage(url: url!)
        return cell
    }
    
    private func setUpSearchBar() {
        recipeSearchBar.delegate = self
    }
    
    
    //Function to get recipes capped at 30S
    func getRecipeSearchResults(with searchPhrase: String) {
        
        let formattedSearchPhrase = searchPhrase.replacingOccurrences(of: " ", with: "+")
        
        //INCREASE RESULTS &maxResult=20
        let searchUrl = "https://api.yummly.com/v1/api/recipes?_app_id=\(Constants.APP_ID)&_app_key=\(Constants.APP_KEY)&q=\(formattedSearchPhrase)&requirePictures=true&maxResult=30"
        print("SEARCH URL: \(searchUrl)")
        
        guard let request = URL(string: searchUrl) else { return }
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
                print("SEARCH RESULT: \(searchResult.matches.count)")
                print(type(of: searchResult))
                let result = RecipeMatches(recipeSearches: searchResult)
                self.results = result
                print("SEARCH RESULTS FDSFDSFSD: \(self.results.searchResults.count)")
                self.RecipeTable.reloadData()

            }  catch let jsonError {
                print("There was an error with your API key \n", jsonError)
            }
        }
        dataTask.resume()
        
    }
}

