//
//  Summary.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-21.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol SummaryViewable {
    func showItems(summary: SummaryEntity)
}

protocol SummaryPresentable {
    func getSummary()
    
    func showItems(summary: SummaryEntity)
}

protocol SummaryModelProtocol {
    func getSummary()
}
