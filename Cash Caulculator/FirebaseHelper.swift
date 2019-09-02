//
//  FirebaseHelper.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CountryCurrency: Codable {
    let bankNoteSign:String
    let bankNoteValue : [Int]
    let code : String
    let coinSign: String
    let coinValue: [Double]
    let sign : String
    let countryName: String
    
    init(key:String,json:[String:Any]) {
        bankNoteSign = json[Constant.bankNoteSignKey] as! String
        bankNoteValue = json[Constant.bankNoteValueKey] as! [Int]
        code = json[Constant.codeKey] as! String
        coinSign = json[Constant.coinSignKey] as! String
        coinValue = json[Constant.coinValueKey] as! [Double]
        sign = json[Constant.signKey] as! String
        countryName = key
    }
}


class FirebaseHelper {
    var databaseRef : DatabaseReference?
    var tableRef: DatabaseReference?
    var countriesCurrency : [CountryCurrency]?{
        didSet{
            if countriesCurrency != nil{
                loadingFinish?.firebaseLoadingFinish()
            }
        }
    }
    
    var loadingFinish:firebaseLoadingFinish?
    
    init() {
        databaseRef = Database.database().reference()
        tableRef = databaseRef?.child(Constant.TableName)
        getCurrencyData(databaseRef: tableRef!)
    }
    
    func getCurrencyData(databaseRef: DatabaseReference){
        databaseRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? [String:[String:Any]] else{
                return
            }
            var localCountriesCurrency : [CountryCurrency] = []
            for key in value.keys{
                let currency = CountryCurrency(key: key, json: value[key]!)
                localCountriesCurrency.append(currency)
            }
            self.countriesCurrency = localCountriesCurrency
            
        }) { (error) in
            print(error)
            return
        }
    }
    
    
}






