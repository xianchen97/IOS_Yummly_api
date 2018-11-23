
import UIKit


//Object to store recipes
class RecipeMatches {
    var recipeSearches = RecipeSearchResult(matches: [])
    
    init(recipeSearches: RecipeSearchResult) {
        self.recipeSearches = recipeSearches
    }
    
    init(){
        
    }
    
    var searchResults: [Match] {
        get {
            return recipeSearches.matches
        }
    }
}
