//
//  Constant.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation

class Constant{
    // Firebase Table Name
    static let TableName = "World Wide Currency"
    
    // The Default Country
    static let defaultCountry = "Australia"
    
    // Userdefault Key
    static let userDefaultKey = "Country"
    
    // MARK: - Country Currency json Keys
    
    static let bankNoteValueKey = "BankNote Value"
    static let codeKey = "Code"
    static let coinValueKey = "Coin Value"
    static let signKey = "Sign"
    
    
    // MARK: - CashCaulculatorTableView forCellReuseIdentifier
    static let cashCaulculatorTableViewforCellReuseIdentifier = "cashCaulculatorTableViewforCellReuseIdentifier"
    
    static let cashCaulculatorTableViewforFooterReuseIdentifier = "cashCaulculatorTableViewforFooterReuseIdentifier"
    
    //MARK: - ChangeCurrencyTableViewController
    static let changeCurrencyTableViewCellReuseIdentifier = "changeCurrencyTableViewCellReuseIdentifier"
    
    
    //MARK: - title Label Content
    static let labelTitles = ["Date","Cashier","From","To", "Account Receivable", "Discount","Proceeds","Cash(p)","Card(p)","Actual Amount","Cash(A)","Card(A)","Difference","Cash(D)","Card(D)","Reason"]
    
    //MARK: - title Label Content
    static let menuArray = ["Count Cash", "Share","Save","Check History","Exit"]
    
    //MARK: - CheckHistoryTabkeViewController identifier
    
    static let checkHistoryTabkeViewControlleridentifier = "CheckHistoryTabkeViewControllerIdentifier"
    
}

