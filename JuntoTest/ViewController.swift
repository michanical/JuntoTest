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
    let network = NetWork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cache = NSCache()
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
    
    @objc private func updateProducts() {
        productHunt.getAllProduct(byCategorieName: currentCategory) {
            (result:[Product]) in
            self.cache.removeAllObjects()
            self.allProducts = result
            self.tableView.reloadData()
            self.refreshCtrl.endRefreshing()
        }
    }
    
    private func setTableViewSettings() {
        tableView?.register(ProductViewCell.nib, forCellReuseIdentifier:
            ProductViewCell.identifier)
        refreshCtrl = UIRefreshControl()
        refreshCtrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCtrl.addTarget(self, action: #selector(self.updateProducts), for: .valueChanged)
        tableView.refreshControl = refreshCtrl
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.estimatedRowHeight = 190
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
    
    @objc private func clickOnButton(button: UIButton) {
        self.changeCategory()
    }
    
    private func changeCategory() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectedProduct" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! ProductController
                dvc.product = allProducts[indexPath.row]
            }
        }
    }
    
    func cacheImage(img: UIImage,indexPath: IndexPath) {
        self.cache.setObject(img, forKey: (indexPath as IndexPath).row as AnyObject)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SelectedProduct", sender: self)
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
            cell.tag = indexPath.row
            if self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil && cell.tag == indexPath.row {
                let thumbnailPict = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
                cell.addDataToProductView(product: allProducts[indexPath.row], picture: thumbnailPict!)
            } else {
                network.getPictureFromUrl(urlString: allProducts[indexPath.row].thumbnailUrl) {
                    (result: UIImage) in
                    self.cacheImage(img: result, indexPath: indexPath)
                    if cell.tag == indexPath.row {
                        cell.addDataToProductView(picture: result)
                    }
                }
                cell.addDataToProductView(product: allProducts[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
}
