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
    var thumbnailUrl: String!
    var upvotes: Int!
    var websiteUrl: String!
    var screenshotUrl: String!
    
    init(newProduct: NSDictionary) {
        super.init()
        
        self.name = newProduct.value(forKey: "name") as! String
        self.tagline = newProduct.value(forKey: "tagline") as! String
        self.upvotes = newProduct.value(forKey: "votes_count") as! Int
        self.websiteUrl = newProduct.value(forKey: "redirect_url") as! String
        
        let thubmnailDict = newProduct.value(forKey: "thumbnail") as! NSDictionary
        self.thumbnailUrl = thubmnailDict.value(forKey: "image_url") as! String
        let screenshotDict = newProduct.value(forKey: "screenshot_url") as! NSDictionary
        self.screenshotUrl = screenshotDict.value(forKey: "300px") as! String
    }
    
}
