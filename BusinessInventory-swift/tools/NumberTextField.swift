//
//  IntegerTextField.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-19.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit

class NumberTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable var allowedChars: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.count > 0 else {
            return true
        }
        
        if(string == "." && allowedChars.contains(".")) {
            let text = self.text
            guard !(text?.contains("."))! else {
                return false
            }
        }

        let allowedCharactersSet = CharacterSet(charactersIn: allowedChars)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharactersSet.isSuperset(of: typedCharacterSet)

    }
}
