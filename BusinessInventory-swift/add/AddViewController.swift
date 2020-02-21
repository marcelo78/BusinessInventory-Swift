//
//  AddViewController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-06.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, AddViewable {
    
    lazy var presenter = AddPresenter(with: self)
    
    var selectedItem = 0
    
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfPlace: UITextField!
    @IBOutlet var tfDescription: UITextField!
    @IBOutlet var tfType: UITextField!
    @IBOutlet var tfDate: UITextField!
    @IBOutlet var tfBarcode: UITextField!
    @IBOutlet var tfBoughtNo: UITextField!
    @IBOutlet var tfSoldNo: UITextField!
    @IBOutlet var tfUnidBuyPriceUs: UITextField!
    @IBOutlet var tfUnidSellPriceUs: UITextField!
    @IBOutlet var tfTotalCostUs: UITextField!
    @IBOutlet var tfTotalReceivedUs: UITextField!
    @IBOutlet var tfTotalProfitUs: UITextField!
    @IBOutlet var tfPhoto: UITextField!
    @IBOutlet var lblMessageError: UILabel!

    var product = ProductEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblMessageError.isHidden = true
        
        if (selectedItem != 0) {
            presenter.getItem(idItem: selectedItem)
        }
        
        tfTotalProfitUs.isEnabled = false
        tfBoughtNo.addTarget(self, action: #selector(AddViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfSoldNo.addTarget(self, action: #selector(AddViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfUnidBuyPriceUs.addTarget(self, action: #selector(AddViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfUnidSellPriceUs.addTarget(self, action: #selector(AddViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfTotalCostUs.addTarget(self, action: #selector(AddViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        tfTotalReceivedUs.addTarget(self, action: #selector(AddViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        selectedItem = 0
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        closeAdd()
    }

    @IBAction func btnSaveClick(_ sender: UIBarButtonItem) {
        lblMessageError.isHidden = true
        product.nameInventory = tfName.text!
        product.place = tfPlace.text!
        product.description = tfDescription.text!
        product.type = tfType.text!
        product.dateProduct = tfDate.text!
        product.barcode = tfBarcode.text!
        product.boughtNo = tfBoughtNo.text?.getValueDouble ?? 0
        product.soldNo = tfSoldNo.text?.getValueDouble ?? 0
        product.unidBuyPriceUS = tfUnidBuyPriceUs.text?.getValueInt ?? 0
        product.unidSellPriceUS = tfUnidSellPriceUs.text?.getValueInt ?? 0
        product.totalCostUS = tfTotalCostUs.text?.getValueDouble ?? 0
        product.totalReceivedUS = tfTotalReceivedUs.text?.getValueInt ?? 0
        product.totalProfitUS = tfTotalProfitUs.text?.getValueInt ?? 0
        product.photo = tfPhoto.text!
        
        let isValid = presenter.validateField(product: product)
        if (isValid) {
            if(selectedItem == 0) {
                presenter.insertItem(product: product)
            } else {
                presenter.updateItem(product: product)
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        fillData()
        presenter.updateData(product: product, value: textField.text!, idEditText: textField.tag)
    }

    func showResult() {
        showToast(message: "Successful")
        closeAdd()
    }
    
    func showErrorMessage(message: String, field: String) {
        switch field {
        case "name":
            tfName.becomeFirstResponder()
        case "place":
            tfPlace.becomeFirstResponder()
        case "description":
            tfDescription.becomeFirstResponder()
        case "type":
            tfType.becomeFirstResponder()
        case "date":
            tfDate.becomeFirstResponder()
        case "barcode":
            tfBarcode.becomeFirstResponder()
        case "boughtNo":
            tfBoughtNo.becomeFirstResponder()
        case "soldNo":
            tfSoldNo.becomeFirstResponder()
        case "unidBuyPriceUS":
            tfUnidBuyPriceUs.becomeFirstResponder()
        case "unidSellPriceUS":
            tfUnidSellPriceUs.becomeFirstResponder()
        case "totalCostUS":
            tfTotalCostUs.becomeFirstResponder()
        case "totalReceivedUS":
            tfTotalReceivedUs.becomeFirstResponder()
        case "totalProfitUS":
            tfTotalProfitUs.becomeFirstResponder()
        case "photo":
            tfPhoto.becomeFirstResponder()
        default:
            print("none")
        }
        lblMessageError.isHidden = false
        lblMessageError.text = message
    }
    
    func populate(product: ProductEntity) {
        self.product = product
        tfName.text = product.nameInventory
        tfPlace.text = product.place
        tfDescription.text = product.description
        tfType.text = product.type
        tfDate.text = product.dateProduct
        tfBarcode.text = product.barcode
        tfBoughtNo.text = "\(product.boughtNo)"
        tfSoldNo.text = "\(product.soldNo)"
        tfUnidBuyPriceUs.text = "\(product.unidBuyPriceUS)"
        tfUnidSellPriceUs.text = "\(product.unidSellPriceUS)"
        tfTotalCostUs.text = "\(product.totalCostUS)"
        tfTotalReceivedUs.text = "\(product.totalReceivedUS)"
        tfTotalProfitUs.text = "\(product.totalProfitUS)"
        tfPhoto.text = product.photo
    }

    func fillData() {
        product.nameInventory = tfName.text!
        product.place = tfPlace.text!
        product.description = tfDescription.text!
        product.type = tfType.text!
        product.dateProduct = tfDate.text!
        product.barcode = tfBarcode.text!
        product.boughtNo = tfBoughtNo.text?.getValueDouble ?? 0
        product.soldNo = tfSoldNo.text?.getValueDouble ?? 0
        product.unidBuyPriceUS = tfUnidBuyPriceUs.text?.getValueInt ?? 0
        product.unidSellPriceUS = tfUnidSellPriceUs.text?.getValueInt ?? 0
        product.totalCostUS = tfTotalCostUs.text?.getValueDouble ?? 0
        product.totalReceivedUS = tfTotalReceivedUs.text?.getValueInt ?? 0
        product.totalProfitUS = tfTotalProfitUs.text?.getValueInt ?? 0
        product.photo = tfPhoto.text!
    }
    
    func clearPreErrors() {
        lblMessageError.isHidden = true
        lblMessageError.text = ""
    }
    
    func closeAdd() {
        self.dismiss(animated: true, completion: nil)
    }

}
