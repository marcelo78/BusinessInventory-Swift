//
//  ItemProduct.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-14.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation
import UIKit

struct ProductLine {
    var id: Int
    var name: String
}

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblPlace: UILabel!
    
}
