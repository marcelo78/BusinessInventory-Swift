//
//  ModelController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-10.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class MainModel: MainModelProtocol {

    var presentable: MainPresentableProtocol?
    var db = DBHelper()
    
    init(with presentable: MainPresentableProtocol) {
        self.presentable = presentable
    }

    func getName(completion: @escaping (String) -> ()) {
        completion("Hello")
    }

    func getNameOther() {
        self.presentable?.showName(name: "Hello World!")
    }

    func getItems() {
        let products = db.readProduct()
        presentable?.showItems(products: products)
    }

}
