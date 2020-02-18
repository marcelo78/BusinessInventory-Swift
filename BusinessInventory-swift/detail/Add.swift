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
    
    func populate(product: Product)
}

protocol AddPresentableProtocol {
    func insertItem(product: Product)
    
    func updateItem(product: Product)
    
    func showResult()
    
    func validateField(product: Product) -> Bool
    
    func getItem(idItem: Int)
    
    func showItem(product: Product)
}

protocol AddModelProtocol {
    func insertItem(product: Product)
    
    func updateItem(product: Product)
    
    func getItem(idItem: Int)
}
