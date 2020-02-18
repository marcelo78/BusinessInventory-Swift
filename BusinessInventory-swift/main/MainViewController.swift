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

    var products: [Product] = []
    var seletedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tvProduct.dataSource = self
        tvProduct.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        seletedItem = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenters.getItems()
    }
    
    func showError() {
        print("Error")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ProductTableViewCell
        
        cell.id = products[indexPath.row].id
        cell.lblName.text = products[indexPath.row].nameInventory
        cell.lblPlace.text = products[indexPath.row].place
        cell.lblDate.text = products[indexPath.row].dateProduct
        cell.lblCost.text = "US$\(products[indexPath.row].totalCostUS)"
        
        cell.lblRem.text = "\(products[indexPath.row].boughtNo - products[indexPath.row].soldNo) of \(products[indexPath.row].boughtNo)"
        var total: Double = 0
        if (products[indexPath.row].boughtNo  == products[indexPath.row].soldNo) {
            total = Double(products[indexPath.row].totalReceivedUS)
        } else {
            total = Double(-products[indexPath.row].totalProfitUS) + (-products[indexPath.row].totalCostUS)
        }
        cell.lblRecv.text = "US$ \(total)"
        cell.lblRecv.textColor = total < 0 ? UIColor.red : UIColor.green
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
        seletedItem = cell.id
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let addViewController = segue.destination as! AddViewController
            addViewController.selectedItem = seletedItem
        }
    }

    func showItems(products: [Product]) {
        self.products = products
        tvProduct.reloadData()
    }

}
