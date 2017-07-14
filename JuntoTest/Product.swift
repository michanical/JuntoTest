//
//  Product.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 13.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import Foundation

class Product: NSObject {
    
    var name: String!
    var tagline: String!
    var thumbnail: String!
    var upvotes: Int!
    var website: String!
    var screenshot: String!
    
    init(newProduct: NSDictionary) {
        super.init()
        
        self.name = newProduct.value(forKey: "name") as! String
        self.tagline = newProduct.value(forKey: "tagline") as! String
        self.upvotes = newProduct.value(forKey: "votes_count") as! Int
        self.website = newProduct.value(forKey: "redirect_url") as! String
        
        let thubmnailDict = newProduct.value(forKey: "thumbnail") as! NSDictionary
        self.thumbnail = thubmnailDict.value(forKey: "image_url") as! String
        let screenshotDict = newProduct.value(forKey: "screenshot_url") as! NSDictionary
        self.screenshot = screenshotDict.value(forKey: "850px") as! String
    }
    
}
