//
//  ProductView.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 14.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var screenshot: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var upvotes: UILabel!
    
    func addDataToProductView(product: Product) {
        self.screenshot.image = UIImage(named: "Apple_logo_black.svg")
        NetWork().getPictureFromUrl(urlString: product.screenshotUrl) {
            (result: UIImage) in
            self.screenshot.image = result
        }
        name.text = product.name
        tagline.text = product.tagline
        upvotes.text = String(product.upvotes)
    }

}
