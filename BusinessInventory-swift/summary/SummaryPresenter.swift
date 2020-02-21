//
//  SummaryPresemter.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-21.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class SummaryPresenter: SummaryPresentable {
    
    var view: SummaryViewable?
    
    lazy var model = SummaryModel(with: self)
    
    init(with view: SummaryViewable) {
        self.view = view
    }

    func getSummary() {
        model.getSummary()
    }
    
    func showItems(summary: SummaryEntity) {
        view?.showItems(summary: summary)
    }

}
