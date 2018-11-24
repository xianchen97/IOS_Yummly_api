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
    }
    
    
    //Return the amount of items that matched the search parameters
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.searchResults.count
        
    }
    
    //Proceed to details view when an item is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "details", sender: results.searchResults[indexPath.row].id)

    }
    
    //Search recipes with query when submitted
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getRecipeSearchResults(with: searchBar.text!)

    }
    
    //Set up table view with values retrieved
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let matches = results.searchResults[indexPath.row].imageUrlsBySize
        let url = matches.first?.value
        cell.imageView?.image = ImageFromUrl().getDetailImage(url: url!)
        cell.textLabel?.text = results.searchResults[indexPath.row].recipeName
        return cell
    }
    
    private func setUpSearchBar() {
        recipeSearchBar.delegate = self
    }
    
    
    func getRecipeSearchResults(with searchPhrase: String) {
        
        //Format query to call API
        let formattedSearchPhrase = searchPhrase.replacingOccurrences(of: " ", with: "+")
        
        let searchUrl = "https://api.yummly.com/v1/api/recipes?_app_id=\(Constants.APP_ID)&_app_key=\(Constants.APP_KEY)&q=\(formattedSearchPhrase)&requirePictures=true&maxResult=30"
        
        guard let request = URL(string: searchUrl) else { return }
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
                let result = RecipeMatches(recipeSearches: searchResult)
                self.results = result
                self.RecipeTable.reloadData()

            }  catch let jsonError {
                print("There was an error with your API key \n", jsonError)
            }
        }
        dataTask.resume()
        
    }
}



