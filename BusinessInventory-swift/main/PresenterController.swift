//
//  Presenter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-12.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class PresenterController: Presentable {
    
    weak var view: ViewPR?
    lazy var model = ModelController(with: self)
    
    init(with view: ViewPR) {
        self.view = view
    }
    
    func getName() {
        print("getName presenter")
//        model.getName { (name) in
//            self.view?.showName(name: name)
//        }
        self.model.getNameOther()
    }

    func showName(name: String) {
        self.view?.showName(name: name)
    }

}
