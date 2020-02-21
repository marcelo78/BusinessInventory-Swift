//
//  Product.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-05.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation

struct ProductEntity {
    var id: Int = 0
    var nameInventory: String = ""
    var place: String = ""
    var description: String = ""
    var type: String = ""
    var dateProduct: String = ""
    var barcode: String = ""
    var boughtNo: Double = 0.0
    var soldNo: Double = 0.0
    var unidBuyPriceUS: Int = 0
    var unidSellPriceUS: Int = 0
    var totalCostUS: Double = 0.0
    var totalReceivedUS: Int = 0
    var totalProfitUS: Int = 0
    var photo: String = ""
}
