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
        productView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
        productView.updateConstraints()
        self.scrollView.addSubview(productView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openWebView(urlString: String) {
        let myWebView:UIWebView = UIWebView(frame: CGRect(x:0, y:0, width: self.view.frame.size.width, height:self.view.frame.size.height))
        self.view.addSubview(myWebView)
        myWebView.delegate = self
        let myURL = URL(string: urlString)
        let myURLRequest:URLRequest = URLRequest(url: myURL!)
        myWebView.loadRequest(myURLRequest)
    }
    
    @IBAction func getItButtonPressed(_ sender: Any) {
        self.openWebView(urlString: product.websiteUrl)
    }

}

extension ProductController: UIWebViewDelegate {
    private func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        print("Webview fail with error \(error)");
    }
    private func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    private func webViewDidStartLoad(webView: UIWebView!) {
        print("Webview started Loading")
    }
    private func webViewDidFinishLoad(webView: UIWebView!) {
        print("Webview did finish load")
    }
}
