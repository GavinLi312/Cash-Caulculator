//
//  SumaryViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 6/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController{
    var countryCurrency: CountryCurrency?
    var countriesCurrency: [CountryCurrency] = []
    
    override func viewDidLoad() {
        setNavigationBar()
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Summary"
        
//        self.navigationController?.navigationItem.setLeftBarButton(<#T##item: UIBarButtonItem?##UIBarButtonItem?#>, animated: <#T##Bool#>)
//
    }
}
