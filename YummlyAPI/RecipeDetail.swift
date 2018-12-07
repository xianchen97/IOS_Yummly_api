//
//  RecipeDetail.swift
//  YummlyAPI
//
//  Created by Xian on 12/6/18.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import Foundation

struct RecipeDetail: Decodable {
    var id: String?
    var name: String?
    var totalTime: String?
    var images: [RecipeImage]
    var ingredientLines: [String]?
    
}
