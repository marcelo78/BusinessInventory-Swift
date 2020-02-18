//
//  DetailPresenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresentableProtocol {
    
    var view: DetailViewProtocol?
    lazy var model = DetailModel(with: self)
    
    init(with view: DetailViewProtocol) {
        self.view = view
    }

}
