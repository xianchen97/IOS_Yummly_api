//
//  Match.swift
//  YummlyAPI
//
//  Created by Xian Chen Ruan on 2018-11-23.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import Foundation

struct Match: Decodable{
    let id: String?
    let recipeName: String?
    let imageUrlsBySize: [String: URL?]
    let sourceDisplayName: String?
}

