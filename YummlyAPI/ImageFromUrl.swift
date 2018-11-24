//
//  ImageFromUrl.swift
//  YummlyAPI
//
//  Created by Xian Chen Ruan on 2018-11-23.
//  Copyright © 2018 Xian Chen Ruan. All rights reserved.
//

import UIKit

class ImageFromUrl {
    func getDetailImage(url: URL) -> UIImage {
        let newUrl = useHttps(url: url)
        if let imageData = try? Data(contentsOf: newUrl) {
            return UIImage(data: imageData)!
        }
        
        return UIImage()
    }
    
    func useHttps(url: URL) -> URL {
        return String(describing: url).range(of:"http:") != nil ? URL(string: String(describing: url).replacingOccurrences(of: "http:", with: "https:"))! : url
    }
}
