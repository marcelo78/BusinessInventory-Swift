//
//  AddViewPresenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation
import UIKit

class AddPresenter: AddPresentableProtocol {

    var view: AddViewProtocol?
    
    lazy var model = AddModel(with: self)
    
    init(with view: AddViewProtocol) {
        self.view = view
    }
    
    func insertItem(product: Product) {
        model.insertItem(product: product)
    }
    
    func showResult() {
        view?.showResult()
    }

    func validateField(product: Product) -> Bool {
        guard (!product.nameInventory.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "name")
            return false
        }
        guard (!product.place.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "place")
            return false
        }
        guard (!product.description.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "description")
            return false
        }
        guard (!product.type.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "type")
            return false
        }
        guard (!product.dateProduct.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "date")
            return false
        }
        guard (!product.barcode.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "barcode")
            return false
        }
        guard (!String(product.boughtNo).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "boughtNo")
            return false
        }
        guard (!String(product.soldNo).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "soldNo")
            return false
        }
        guard (!String(product.unidBuyPriceUS).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "unidBuyPriceUS")
            return false
        }
        guard (!String(product.unidSellPriceUS).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "unidSellPriceUS")
            return false
        }
        guard (!String(product.totalCostUS).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "totalCostUS")
            return false
        }
        guard (!String(product.totalReceivedUS).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "totalReceivedUS")
            return false
        }
        guard (!String(product.totalProfitUS).isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "totalProfitUS")
            return false
        }
        guard (!product.photo.isEmpty) else {
            view?.showErrorMessage(message: "Empty Field", field: "photo")
            return false
        }
        return true
    }

    func getItem(idItem: Int) {
        model.getItem(idItem: idItem)
    }

    func showItem(product: Product) {
        view?.populate(product: product)
    }
    
    func updateItem(product: Product) {
        model.updateItem(product: product)
    }

}
