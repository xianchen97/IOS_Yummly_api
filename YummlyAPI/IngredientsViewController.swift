//
//  IngredientsViewController.swift
//  YummlyAPI
//
//  Created by Xian on 12/7/18.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import UIKit
import CoreData

class IngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDelegate, UISearchBarDelegate{
    var items = [String]()
    var search:IngredientBundle = IngredientBundle()
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var searchRecipe: UISearchBar!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    @IBAction func searchTapped(_ sender: Any) {
        var query = String()
        query = createURL(items)
        performSegue(withIdentifier: "IngredientSearch", sender: query)
    }
    
    private func setUpSearchBar() {
        searchRecipe.delegate = self
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    @IBAction func addButton(_ sender: Any) {
        insertNewIngredient()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var query = String()
        query = createURL(items)
         search.url_query = query
         search.search = searchRecipe.text!
        performSegue(withIdentifier: "IngredientSearch", sender: search)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        tabBarController!.viewControllers?.remove(at:1)  // for 1 index

    }
    
    func insertNewIngredient() {
        if !ingredientField.text!.isEmpty{
            items.append(ingredientField.text!)
            let indexPath = IndexPath(row: items.count-1, section: 0)
            ingredientTable.beginUpdates()
            ingredientTable.insertRows(at: [indexPath], with: .automatic)
            ingredientTable.endUpdates()
        }
      
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            items.remove(at: indexPath.row)
            ingredientTable.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ViewController
        viewController.url_query = search
    }
    
    func  createURL(_: [String]) -> String {
        var query  = String()
        for i in items{
            query.append("&allowedIngredient[]=")
            query.append(i)
        }
        return query
    }
    
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


