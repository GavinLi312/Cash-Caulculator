//
//  FirebaseHelper.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import FirebaseDatabase

// Country Currency, to receive the value from firebase
struct CountryCurrency: Codable {
    let bankNoteValue : [Int]
    let code : String
    let coinValue: [Double]
    let sign : String
    let countryName: String
    
    init(key:String,json:[String:Any]) {
        bankNoteValue = json[Constant.bankNoteValueKey] as! [Int]
        code = json[Constant.codeKey] as! String
        coinValue = json[Constant.coinValueKey] as! [Double]
        sign = json[Constant.signKey] as! String
        countryName = key
    }
}


// Firebase
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
    
    // get data from firebase
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






