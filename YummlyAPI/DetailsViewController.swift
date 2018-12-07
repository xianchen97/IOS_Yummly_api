//
//  DetailsViewController.swift
//  YummlyAPI
//
//  Created by Xian Chen Ruan on 2018-11-23.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, URLSessionDelegate, UITableViewDelegate, UITableViewDataSource  {
    var recipe_key = String()
    var detail: Details = Details()
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredients: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW LOADED")
        print(recipe_key)
        let searchUrl = "https://api.yummly.com/v1/api/recipe/\(recipe_key)?_app_id=\(Constants.APP_ID)&_app_key=\(Constants.APP_KEY)"
        
        print(searchUrl)
        
        guard let request = URL(string: searchUrl) else { return }
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(RecipeDetail.self, from: data)
                print(searchResult)
                self.detail.recipeDetails = searchResult
                self.recipeName.text = searchResult.name
                self.recipeImage.image = ImageFromUrl().getDetailImage(url: searchResult.images[0].hostedLargeUrl!)
                self.recipeName.lineBreakMode = .byClipping
                self.recipeName.textAlignment = .center
                self.ingredients.reloadData()
            }  catch let jsonError {
                print("There was an error with your API key \n", jsonError)
            }
        }
        dataTask.resume()
        ingredients.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
    }
    
    //Return the amount of items that matched the search parameters
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.detail.recipeDetails.ingredientLines?.count)!
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let line = detail.recipeDetails.ingredientLines?[indexPath.row]
        cell.textLabel?.text = line
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("fdsfsdfs")
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

