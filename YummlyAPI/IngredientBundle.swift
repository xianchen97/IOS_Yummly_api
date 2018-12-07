//
//  IngredientBundle.swift
//  YummlyAPI
//
//  Created by Xian on 12/7/18.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import Foundation
import UIKit

class IngredientBundle{
    var url_query = String()
    var search = String()
    
    init(){
        
    }
    
    init(url_q: String, search_q:String){
            self.url_query = url_q
            self.search = search_q
    }
}
