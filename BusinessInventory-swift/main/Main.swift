//
//  MainView.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-10.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol MainViewable {
    func showError()

    func showItems(products: [ProductEntity])
}

protocol MainPresentable {
    func getItems()
 
    func showItems(products: [ProductEntity])
}

protocol MainModelProtocol {
    func getItems()
}
