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
    func showName(name: String)
}

protocol MainPresentableProtocol {
    func getName()
    func showName(name: String)
}

protocol MainModelProtocol {
    func getName(completion: @escaping (String) -> ())
    func getNameOther()
}
