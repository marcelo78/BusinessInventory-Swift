//
//  SummaryModel.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-21.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class SummaryModel: SummaryModelProtocol {
    
    var presentable: SummaryPresentable?
    var db = DBHelper()
    
    init(with presentable: SummaryPresentable) {
        self.presentable = presentable
    }

    func getSummary() {
        let summary = db.getSummary()
        presentable?.showItems(summary: summary)
    }
    
}
