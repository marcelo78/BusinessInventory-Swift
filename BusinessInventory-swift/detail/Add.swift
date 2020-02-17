//
//  Add.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol AddViewProtocol {
    func showResult()
    
    func showErrorMessage(message: String, field: String)
}

protocol AddPresentableProtocol {
    func insertItem(product: Product)
    
    func showResult()
    
    func validateField(product: Product) -> Bool
}

protocol AddModelProtocol {
    func insertItem(product: Product)
}
