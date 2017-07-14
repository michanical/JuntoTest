//
//  ProductView.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 13.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import UIKit

class ProductViewCell: UITableViewCell {

    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tageline: UILabel!
    @IBOutlet weak var upvotes: UILabel!
    
    func addDataToProductView(product: Product) {
        NetWork().getPictureFromUrl(urlString: product.thumbnailUrl) {
            (result: UIImage) in
            self.thumbnail.image = result
        }
        name.text = product.name
        tageline.text = product.tagline
        upvotes.text = String(product.upvotes)
    }

}
