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
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblCost: UILabel!
    @IBOutlet var lblRem: UILabel!
    @IBOutlet var lblRecv: UILabel!
    @IBOutlet var cellView: UIView!
    var id: Int = 0
    
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        cellView.layer.cornerRadius = 5
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = shadowColor?.cgColor
        cellView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        cellView.layer.shadowOpacity = shadowOpacity
        cellView.layer.borderWidth = 1.0
        cellView.layer.borderColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.1).cgColor

    }
}
