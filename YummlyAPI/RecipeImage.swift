//
//  RecipeImage.swift
//  YummlyAPI
//
//  Created by Xian on 12/6/18.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import Foundation
struct RecipeImage: Decodable {
    var hostedLargeUrl: URL?
    var imageUrlsBySize: [String: URL]
}
