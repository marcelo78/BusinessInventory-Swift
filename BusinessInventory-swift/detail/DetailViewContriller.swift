//
//  DetailViewContriller.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-18.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit
//import SDWebImage

class DetailViewController: UIViewController, DetailViewProtocol {
    
    lazy var presenters = DetailPresenter(with: self)
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!

    
    let headerViewMaxHeight: CGFloat = 250
    let headerViewMinHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.height
    
    var seletedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
