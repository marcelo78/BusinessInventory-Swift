//
//  AddViewModel.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class AddModel: AddModelProtocol {

    var presentable: AddPresentable?
    var db = DBHelper()
    
    init(with presentable: AddPresentable) {
        self.presentable = presentable
    }
    
    func insertItem(product: ProductEntity) {
        db.insertProduct(product: product)
        presentable?.showResult()
    }

    func getItem(idItem: Int) {
        let product = db.getProduct(idItem: idItem)
        presentable?.showItem(product: product)
    }

    func updateItem(product: ProductEntity) {
        db.updateProduct(product: product)
        presentable?.showResult()
    }

}
