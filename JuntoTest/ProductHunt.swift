//
//  ProductHunt.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 13.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import Foundation

class ProductHunt {

    private let categorieUrl = "https://api.producthunt.com/v1/categories"
    private let productUrl = "https://api.producthunt.com/v1/categories/"
    
    func getAllCategories(completion: @escaping (_ result: [ProductCategory]) -> Void) {
        NetWork().getFromProductHunt(urlString: self.categorieUrl) {
            (result: Data) in
            let parsedDict = NetWork().parseJson(data: result)
            let categoriesDict = parsedDict.value(forKey: "categories") as! [NSDictionary]
            var allCategories = [ProductCategory]()
            for categorie in categoriesDict {
                allCategories.append(ProductCategory(newCategory: categorie))
            }
            completion(allCategories)
        }
    }
    
    func getAllProduct(byCategorieName: String, completion: @escaping (_ result: [Product]) -> Void) {
        let productUrlWithCategory = self.productUrl + byCategorieName + "/posts"
        NetWork().getFromProductHunt(urlString: productUrlWithCategory) {
            (result: Data) in
            let parsedDict = NetWork().parseJson(data: result)
            let productsDict = parsedDict.value(forKey: "posts") as! [NSDictionary]
            var allProducts = [Product]()
            for product in productsDict {
                allProducts.append(Product(newProduct: product))
            }
            completion(allProducts)
        }
    }
    
}
