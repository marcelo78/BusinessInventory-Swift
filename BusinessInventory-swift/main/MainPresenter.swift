//
//  Presenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-12.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class MainPresenter: MainPresentable {
    
    var view: MainViewable?
    lazy var model = MainModel(with: self)
    
    init(with view: MainViewable) {
        self.view = view
    }
    
    func getItems() {
        model.getItems()
    }
    
    func showItems(products: [ProductEntity]) {
        view?.showItems(products: products)
    }

}
