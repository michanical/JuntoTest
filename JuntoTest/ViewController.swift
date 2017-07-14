//
//  ViewController.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 12.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshCtrl: UIRefreshControl!
    var cache:NSCache<AnyObject, AnyObject>!
    
    private var currentCategory = "tech"
    var allProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.setTableViewSettings()
    }
    
    private func getData() {
        ProductHunt().getAllProduct(byCategorieName: currentCategory) {
            (result:[Product]) in
            self.allProducts = result
            self.tableView.reloadData()
        }
    }
    
    private func setTableViewSettings() {
        tableView?.register(ProductViewCell.nib, forCellReuseIdentifier:
            ProductViewCell.identifier)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("a")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            ProductViewCell.identifier, for: indexPath) as? ProductViewCell
        {
            cell.addDataToProductView(product: allProducts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
