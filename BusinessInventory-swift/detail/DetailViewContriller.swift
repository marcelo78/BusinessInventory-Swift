//
//  DetailViewContriller.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

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
    let floatingButton = MDCFloatingButton()
    let containerScheme = MDCContainerScheme()
    
    var selectedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let plusImage = UIImage(named: "ic_action_edit")
        floatingButton.setImage(plusImage, for: .normal)
        floatingButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        floatingButton.setElevation(ShadowElevation(rawValue: 12), for: .highlighted)
        floatingButton.minimumSize = CGSize(width: 50, height: 50)
        containerScheme.colorScheme.primaryColor = .red
        containerScheme.colorScheme.backgroundColor = .red
        floatingButton.applySecondaryTheme(withScheme: containerScheme)
        floatingButton.setBackgroundColor(UIColor(cgColor: CGColor(srgbRed: 0, green: 133/255, blue: 119/255, alpha: 1)))
        floatingButton.addTarget(self, action: #selector(DetailViewController.floatingButtonEdit(_:)), for: .touchUpInside)

        self.view.addSubview(floatingButton)
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: floatingButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: floatingButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 314)
        let widthConstraint = NSLayoutConstraint(item: floatingButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        let heightConstraint = NSLayoutConstraint(item: floatingButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
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
    
    @objc func floatingButtonEdit(_ floatingButton: MDCFloatingButton) {
        self.performSegue(withIdentifier: "edit", sender: nil)
    }

    @IBAction func goBack(_ sender: Any) {
        closeDetail()
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
