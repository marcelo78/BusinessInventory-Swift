//
//  DetailModel.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class DetailModel: DetailModelProtocol {

    var presentable: DetailPresentable?
    var db = DBHelper()
    
    init(with presentable: DetailPresentable) {
        self.presentable = presentable
    }

    func getItem(idItem: Int) {
        let product = db.getProduct(idItem: idItem)
        presentable?.showItem(product: product)
    }

    func deleteItem(idItem: Int) {
        db.deleteProductByID(id: idItem)
        presentable?.showResult()
    }

}
