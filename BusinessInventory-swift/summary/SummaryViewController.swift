//
//  SummaryViewController.swift
//  BusinessInventory-swift
//
//  Created by Marcelo Agudelo on 2020-02-21.
//  Copyright © 2020 Marcelo Agudelo. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, SummaryViewable {
    
    lazy var presenter = SummaryPresenter(with: self)
    
    @IBOutlet var viewCurrentUs: UILabel!
    @IBOutlet var viewCurrentNo: UILabel!
    @IBOutlet var viewInventorySold: UILabel!
    @IBOutlet var viewProfitMargin: UILabel!
    @IBOutlet var viewAccumProfitsUs: UILabel!
    @IBOutlet var viewNetProfitUs: UILabel!
    @IBOutlet var viewTotalBoughtUs: UILabel!
    @IBOutlet var viewTotalSoldUs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.getSummary()
    }
    
    func showItems(summary: SummaryEntity) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        viewCurrentUs.text = formatter.string(from: summary.data1 as NSNumber)
        viewCurrentNo.text = formatter.string(from: summary.data2 as NSNumber)
        viewInventorySold.text = formatter.string(from: summary.data3 as NSNumber)
        viewProfitMargin.text = formatter.string(from: ((summary.data4 / summary.data5) * 100) as NSNumber)
        viewAccumProfitsUs.text = formatter.string(from: (summary.data1 - summary.data4) as NSNumber)
        viewNetProfitUs.text = formatter.string(from: summary.data4 as NSNumber)
        viewTotalBoughtUs.text = formatter.string(from: summary.data5 as NSNumber)
        viewTotalSoldUs.text = formatter.string(from: summary.data6 as NSNumber)
    }

}
