//
//  ViewController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-05.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ViewPR {
    
    lazy var presenters = PresenterController(with: self)
    
    @IBOutlet var changeTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTab(_ sender: UIButton) {
//        presenter.buttonTapped()
        presenters.getName()
    }

    func showError() {
        print("Error")
    }
    
    func showName(name: String) {
        changeTextLabel.text = name
        print("showName View: \(name)")
    }

}
