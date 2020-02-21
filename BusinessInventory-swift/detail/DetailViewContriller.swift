//
//  DetailViewContriller.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, DetailViewable {
    
    lazy var presenter = DetailPresenter(with: self)
    
    @IBOutlet var imageItem: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var navBar: UINavigationItem!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblPlace: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    var selectedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        refreshUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshUI()
    }
    
    func refreshUI() {
        if (self.selectedItem != 0) {
            presenter.getItem(idItem: selectedItem)
        }
    }

    func showResult() {
        closeDetail()
    }
    
    func populate(product: ProductEntity) {
        lblName.text = product.nameInventory
        navBar.title = product.nameInventory
        lblDate.text = product.dateProduct
        lblDescription.text = product.description
        lblPlace.text = product.place
        lblType.text = product.type
        lblPrice.text = "US$ \(product.unidSellPriceUS)"
        
        let img = UIImage(named: "ic_action_foto")

        imageItem.sd_setImage(with: URL(string: product.photo), placeholderImage: img)
    }

    @IBAction func goBack(_ sender: Any) {
        closeDetail()
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "edit", sender: nil)
    }
    
    func closeDetail() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnDelete(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Really Delete?", message: "Are you sure to delete this?", preferredStyle: .actionSheet)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            print("User click Yes button")
            self.presenter.deleteItem(idItem: self.selectedItem)
        }))

        refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            print("User click No button")
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Cancel button")
        }))

        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "edit") {
            let addViewController = segue.destination as! AddViewController
            addViewController.selectedItem = selectedItem
        }
    }

}
