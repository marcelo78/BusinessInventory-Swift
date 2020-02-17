//
//  MainView.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-10.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol MainViewProtocol {
    func showError()

    func showItems(products: [Product])
}

protocol MainPresentableProtocol {
    func getItems()
 
    func showItems(products: [Product])
}

protocol MainModelProtocol {
    func getItems()
}
