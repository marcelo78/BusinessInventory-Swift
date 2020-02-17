//
//  Presenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-12.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class MainPresenter: MainPresentableProtocol {
    
    var view: MainViewProtocol?
    lazy var model = MainModel(with: self)
    
    init(with view: MainViewProtocol) {
        self.view = view
    }
    
    func getItems() {
        model.getItems()
    }
    
    func showItems(products: [Product]) {
        view?.showItems(products: products)
    }

}
