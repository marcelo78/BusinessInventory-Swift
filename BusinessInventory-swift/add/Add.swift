//
//  Add.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol AddViewable {
    func showResult()
    
    func showErrorMessage(message: String, field: String)
    
    func populate(product: ProductEntity)
    
    func clearPreErrors()
}

protocol AddPresentable {
    func insertItem(product: ProductEntity)
    
    func updateItem(product: ProductEntity)
    
    func showResult()
    
    func validateField(product: ProductEntity) -> Bool
    
    func getItem(idItem: Int)
    
    func showItem(product: ProductEntity)
    
    func updateData(product: ProductEntity, value: String, idEditText: Int)
}

protocol AddModelProtocol {
    func insertItem(product: ProductEntity)
    
    func updateItem(product: ProductEntity)
    
    func getItem(idItem: Int)
}
