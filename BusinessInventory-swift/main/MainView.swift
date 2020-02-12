//
//  MainView.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-10.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

protocol ViewPR: class {
    func showError()
    func showName(name: String)
}

protocol Presentable {
    func getName()
    func showName(name: String)
}

protocol Model {
    func getName(completion: @escaping (String) -> ())
    func getNameOther()
}
