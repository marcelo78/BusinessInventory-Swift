//
//  AddViewPresenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation
import UIKit

class AddPresenter: AddPresentable {

    var view: AddViewable?
    
    lazy var model = AddModel(with: self)
    
    init(with view: AddViewable) {
        self.view = view
    }
    
    func insertItem(product: ProductEntity) {
        model.insertItem(product: product)
    }
    
    func showResult() {
        view?.showResult()
    }

    func validateField(product: ProductEntity) -> Bool {
        view?.clearPreErrors()
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

    func showItem(product: ProductEntity) {
        view?.populate(product: product)
    }
    
    func updateItem(product: ProductEntity) {
        model.updateItem(product: product)
    }

    func updateData(product: ProductEntity, value: String, idEditText: Int) {
        var product = product
        switch idEditText {
        case 7, 8: // R.id.etBoughtNo, R.id.etSoldNo
            if (idEditText == 7) {
                product.boughtNo = value.getValueDouble
            } else {
                product.soldNo = value.getValueDouble
            }
            product.totalCostUS = product.boughtNo * String(product.unidBuyPriceUS).getValueDouble
            product.totalReceivedUS = String(product.soldNo).getValueInt * product.unidSellPriceUS
            product.totalProfitUS = product.totalReceivedUS - String(product.totalCostUS).getValueInt
        case 9: // R.id.etUnidBuyPrice
            product.unidBuyPriceUS = value.getValueInt
            product.totalCostUS = product.boughtNo * String(product.unidBuyPriceUS).getValueDouble
            product.totalProfitUS = product.totalReceivedUS - String(product.totalCostUS).getValueInt
        case 10: // R.id.etUnidSellPrice
            product.unidSellPriceUS = value.getValueInt
            product.totalReceivedUS = String(product.soldNo).getValueInt * product.unidSellPriceUS
            product.totalProfitUS = product.totalReceivedUS - String(product.totalCostUS).getValueInt
        case 11: // R.id.etTotalCost
            product.totalCostUS = value.getValueDouble

            let soldNo = product.soldNo
            let unidSellPriceUs = product.unidSellPriceUS
            if (soldNo > 0 && unidSellPriceUs > 0) {
                product.totalReceivedUS = String(product.soldNo).getValueInt * product.unidSellPriceUS
            }
            let totalCostUS = product.totalCostUS
            if (totalCostUS > 0) {
                product.totalProfitUS = product.totalReceivedUS - String(product.totalCostUS).getValueInt
            }
            product.unidBuyPriceUS = 0
        case 12: // R.id.etTotalReceived
            product.totalReceivedUS = value.getValueInt
            let totalCostUS = product.totalCostUS
            if (totalCostUS > 0) {
                product.totalProfitUS = product.totalReceivedUS - String(product.totalCostUS).getValueInt
            }
            product.unidSellPriceUS = 0
        default:
            print("")
        }
        view?.populate(product: product)
    }
    
}
