//
//  Tools.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-13.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var getValueInt: Int {
        let value = self
        if value != "" {
            if value.contains(".") {
                let valueDouble: Double = value.getValueDouble
                return Int(valueDouble)
            } else {
                return Int(self) ?? 0
            }
        } else {
            return 0
        }
    }
    
    var getValueDouble: Double {
        let value = self
        if value != "" {
            return Double(self) ?? 0.0
        } else {
            return 0.0
        }
    }
}

extension UIViewController {
    func showToast(message: String) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        let lblToast = UILabel()
        lblToast.text = message
        lblToast.textAlignment = .center
        lblToast.font = UIFont.systemFont(ofSize: 18)
        lblToast.textColor = UIColor.white
        lblToast.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        lblToast.numberOfLines = 0
        lblToast.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblToast.sizeToFit()
        
        let textSize = lblToast.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let labelHeight = (textSize.width / window.frame.width) * 30
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        lblToast.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight + 10)
        lblToast.center.x = window.center.x
        lblToast.layer.cornerRadius = 10
        lblToast.layer.masksToBounds = true
        
        window.addSubview(lblToast)
        
        UIView.animate(withDuration: 3.0, animations: {
            lblToast.alpha = 0
        }) { (_) in
            lblToast.removeFromSuperview()
        }
    }
}
