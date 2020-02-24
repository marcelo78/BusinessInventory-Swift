//
//  ViewController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-05.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class MainViewController: UIViewController, MainViewable, UITableViewDelegate, UITableViewDataSource {
    
    lazy var presenters = MainPresenter(with: self)
    
    @IBOutlet var tvProduct: UITableView!

    var products: [ProductEntity] = []
    var selectedItem = 0
    
    let floatingButton = MDCFloatingButton()
    let containerScheme = MDCContainerScheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tvProduct.dataSource = self
        tvProduct.delegate = self
        
        let margins = view.layoutMarginsGuide
        
        let plusImage = UIImage(named: "ic_action_add")
        floatingButton.setImage(plusImage, for: .normal)
        floatingButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        floatingButton.setElevation(ShadowElevation(rawValue: 12), for: .highlighted)
        floatingButton.minimumSize = CGSize(width: 50, height: 50)
        containerScheme.colorScheme.primaryColor = .red
        containerScheme.colorScheme.backgroundColor = .red
        floatingButton.applySecondaryTheme(withScheme: containerScheme)
        floatingButton.setBackgroundColor(UIColor(cgColor: CGColor(srgbRed: 0, green: 133/255, blue: 119/255, alpha: 1)))
        floatingButton.addTarget(self, action: #selector(MainViewController.floatingButtonAdd(_:)), for: .touchUpInside)

        self.view.addSubview(floatingButton)
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        floatingButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true

        floatingButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func floatingButtonAdd(_ floatingButton: MDCFloatingButton) {
        self.performSegue(withIdentifier: "add", sender: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        selectedItem = 0
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
        selectedItem = cell.id
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.selectedItem = selectedItem
        }
    }

    func showItems(products: [ProductEntity]) {
        self.products = products
        tvProduct.reloadData()
    }

}
