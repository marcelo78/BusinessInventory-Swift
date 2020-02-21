//
//  Detail.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol DetailViewable {
    func populate(product: ProductEntity)
    
    func showResult()
}

protocol DetailPresentable {
    func getItem(idItem: Int)
    
    func showItem(product: ProductEntity)
    
    func deleteItem(idItem: Int)
    
    func showResult()
}

protocol DetailModelProtocol {
    func getItem(idItem: Int)
    func deleteItem(idItem: Int)
}
