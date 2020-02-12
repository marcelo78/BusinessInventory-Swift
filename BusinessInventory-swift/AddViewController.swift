//
//  AddViewController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-06.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        closeAdd()
    }
    
    func closeAdd() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
