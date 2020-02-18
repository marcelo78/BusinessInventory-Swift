//
//  DetailModel.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

class DetailModel: DetailModelProtocol {

    var presentable: DetailPresentableProtocol?
    var db = DBHelper()
    
    init(with presentable: DetailPresentableProtocol) {
        self.presentable = presentable
    }

}
