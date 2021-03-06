//
//  Catogorie.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 13.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import Foundation

class ProductCategory: NSObject {
    
    var name: String!
    var slug: String!
    
    init(newCategory: NSDictionary) {
        super.init()
        
        self.name = newCategory.value(forKey: "name") as! String
        self.slug = newCategory.value(forKey: "slug") as! String
    }
    
}
