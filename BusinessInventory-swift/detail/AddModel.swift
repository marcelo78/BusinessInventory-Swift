//
//  AddViewModel.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class AddModel: AddModelProtocol {

    var presentable: AddPresentableProtocol?
    var db = DBHelper()
    
    init(with presentable: AddPresentableProtocol) {
        self.presentable = presentable
    }
    
    func insertItem(product: Product) {
        db.insertProduct(product: product)
        presentable?.showResult()
    }
    
}
