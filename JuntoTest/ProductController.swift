//
//  SelectedProductController.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 14.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import UIKit

class ProductController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var product: Product!
    var productView = ProductView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productView = Bundle.main.loadNibNamed("ProductView", owner: self, options: nil)?.last as! ProductView
        productView.addDataToProductView(product: self.product)
        productView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: self.scrollView.frame.size.width,
                                   height: self.scrollView.frame.size.height)
        productView.updateConstraints()
        self.scrollView.addSubview(productView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func openWebView(urlString: String) {
        let myWebView:UIWebView = UIWebView(frame: CGRect(x:0,
                                                          y:(self.navigationController?.navigationBar.frame.size.height)!,
                                                          width: self.view.frame.size.width,
                                                          height:self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)!))
        myWebView.tag = 10
        self.view.addSubview(myWebView)
        myWebView.delegate = self
        let myURL = URL(string: urlString)
        let myURLRequest:URLRequest = URLRequest(url: myURL!)
        myWebView.loadRequest(myURLRequest)
    }
    
    @IBAction func getItButtonPressed(_ sender: Any) {
        self.openWebView(urlString: product.websiteUrl)
        print(scrollView.frame.size.height)
    }
    
    func closeWebView() {
        self.view.viewWithTag(10)?.removeFromSuperview()
        self.navigationItem.rightBarButtonItem = nil
    }

}

extension ProductController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
         let closeButton = UIBarButtonItem(
            title: "CloseWeb",
            style: .plain,
            target: self,
            action: #selector(self.closeWebView)
        )
        self.navigationItem.rightBarButtonItem = closeButton
    }
}
