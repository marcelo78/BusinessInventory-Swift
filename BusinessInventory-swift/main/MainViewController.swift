//
//  ViewController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-05.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    lazy var presenters = MainPresenter(with: self)
    
    @IBOutlet var tvProduct: UITableView!

    let animalArray = ["Cat", "Dog", "Snake", "Spider", "Horse", "Mouse"]
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tvProduct.dataSource = self
        tvProduct.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenters.getItems()
    }
    
    func showError() {
        print("Error")
    }
    
    func showName(name: String) {
        print("showName View: \(name)")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ProductTableViewCell
        
        cell.lblName.text = products[indexPath.row].nameInventory
        cell.lblPlace.text = products[indexPath.row].place

        return cell
    }

    func showItems(products: [Product]) {
        self.products = products
        tvProduct.reloadData()
        print("data")
    }

}
