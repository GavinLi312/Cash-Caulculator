//
//  Constant.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation

class Constant{
    static let TableName = "World Wide Currency"
    
    static let defaultCountry = "Australia"
    
    static let userDefaultKey = "Country"
    
    // MARK: - Country Currency json Keys
    
    static let bankNoteSignKey = "BankNote Sign"
    static let bankNoteValueKey = "BankNote Value"
    static let codeKey = "Code"
    static let coinSignKey = "Coin Sign"
    static let coinValueKey = "Coin Value"
    static let signKey = "Sign"
    
    
    // MARK: - CashCaulculatorTableView forCellReuseIdentifier
    static let cashCaulculatorTableViewforCellReuseIdentifier = "cashCaulculatorTableViewforCellReuseIdentifier"
    
    static let cashCaulculatorTableViewforFooterReuseIdentifier = "cashCaulculatorTableViewforFooterReuseIdentifier"
    
    //MARK: - ChangeCurrencyTableViewController
    static let changeCurrencyTableViewCellReuseIdentifier = "changeCurrencyTableViewCellReuseIdentifier"
}
