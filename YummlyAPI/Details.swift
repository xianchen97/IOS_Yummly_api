//
//  Details.swift
//  YummlyAPI
//
//  Created by Xian on 12/6/18.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import UIKit
import Foundation

class Details {
    var recipeDetails = RecipeDetail(id: "", name: "", totalTime: "", images: [], ingredientLines: [])
    init(recipeDetail: RecipeDetail) {
        self.recipeDetails = recipeDetail
    }
    
    init(){
        
    }
    
}
