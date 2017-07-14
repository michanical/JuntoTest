//
//  ProductView.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 13.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tageline: UILabel!
    @IBOutlet weak var upvotes: UILabel!
    
    func addDataToProductView(product: Product) {
        thumbnail.setImageFromURl(stringImageUrl: product.thumbnailUrl)
        name.text = product.name
        tageline.text = product.tagline
        upvotes.text = String(product.upvotes)
    }

}

extension UIImageView{
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf:url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
