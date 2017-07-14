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
    private var allCategories = [ProductCategory]()
    private let productHunt = ProductHunt()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.setTableViewSettings()
        self.createTitleButton()
    }
    
    private func getData() {
        self.updateProducts()
        productHunt.getAllCategories() {
            (result:[ProductCategory]) in
            self.allCategories = result
        }
    }
    
    private func updateProducts() {
        allProducts.removeAll()
        productHunt.getAllProduct(byCategorieName: currentCategory) {
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
    
    private func createTitleButton() {
        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Tech", for: .normal)
        button.addTarget(self, action: #selector(self.clickOnButton), for: .touchUpInside)
        self.navigationItem.titleView = button
    }
    
    func clickOnButton(button: UIButton) {
        self.changeCategory()
    }
    
    func changeCategory() {
        let optionMenu = UIAlertController(title: nil, message: "Choose category", preferredStyle: .actionSheet)
        for categorie in allCategories {
            let newAction = UIAlertAction(title: categorie.name, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.currentCategory = categorie.slug
                let button = self.navigationItem.titleView as! UIButton
                button.setTitle(categorie.name, for: .normal)
                self.updateProducts()
            })
            optionMenu.addAction(newAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
