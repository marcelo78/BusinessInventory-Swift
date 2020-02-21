//
//  DetailPresenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresentable {
    
    var view: DetailViewable?
    lazy var model = DetailModel(with: self)
    
    init(with view: DetailViewable) {
        self.view = view
    }

    func getItem(idItem: Int) {
        model.getItem(idItem: idItem)
    }

    func showItem(product: ProductEntity) {
        view?.populate(product: product)
    }

    func deleteItem(idItem: Int) {
        model.deleteItem(idItem: idItem)
    }
    
    func showResult() {
        view?.showResult()
    }

}
