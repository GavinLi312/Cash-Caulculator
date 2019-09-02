//
//  ViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import UIKit

protocol firebaseLoadingFinish {
   func  firebaseLoadingFinish()
}

class LoadingViewController: UIViewController, firebaseLoadingFinish{

    let firebaseHelper = FirebaseHelper()
    let activityIndicator : UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
//        indicator.color = UIColor.white
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseHelper.loadingFinish = self
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func firebaseLoadingFinish() {
       activityIndicator.stopAnimating()
        let country = readUserDefaultCountry()
        let caulculatorViewController = CashCaulculatorTableViewController()

        let currency = firebaseHelper.countriesCurrency?.filter({
            $0.countryName == country
        })
        caulculatorViewController.country = country
        caulculatorViewController.countryCurrency = currency?.first
        caulculatorViewController.countryCurrencies = firebaseHelper.countriesCurrency
        let navigationController = UINavigationController(rootViewController: caulculatorViewController)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    func readUserDefaultCountry() -> String{
        let userdefault = UserDefaults()
        if let country = userdefault.string(forKey: Constant.userDefaultKey) {
            return country
        }else{
            userdefault.set(Constant.defaultCountry, forKey: Constant.userDefaultKey)
            return Constant.defaultCountry
        }
    }

}

