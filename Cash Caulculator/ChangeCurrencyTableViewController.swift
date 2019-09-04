//
//  ChangeCurrencyTableViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 2/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit


protocol NewCountrySelected {
    
    func newCountrySelected(countryCurrency:CountryCurrency)
    
}

class ChangeCurrencyTableViewController : UITableViewController,UISearchResultsUpdating{

    var countryCurrencies: [CountryCurrency]?
    
    var newCountry: NewCountrySelected?
    
    var filteredCountryCurrencies : [CountryCurrency] = []
    //search Controller
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        self.navigationItem.title = "Currency"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.fillcolor
        self.view.backgroundColor = UIColor.backgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.changeCurrencyTableViewCellReuseIdentifier)
        filteredCountryCurrencies = countryCurrencies!
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Currency Code / Country"
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,searchText.count > 0{
            filteredCountryCurrencies = (countryCurrencies?.filter({
                if  $0.countryName.contains(searchText){
                    return true
                }else if $0.code.contains(searchText){
                    return true
                }else{
                    return false
                }
            }))!
        }else{
            filteredCountryCurrencies = countryCurrencies!
        }
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountryCurrencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Constant.changeCurrencyTableViewCellReuseIdentifier)
        cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        cell.backgroundColor = UIColor.backgroundColor
        let countryCurrency = filteredCountryCurrencies[indexPath.row]
        cell.textLabel?.text = countryCurrency.code
        cell.textLabel?.backgroundColor = cell.contentView.backgroundColor
        cell.detailTextLabel?.backgroundColor = cell.contentView.backgroundColor
        cell.detailTextLabel?.text = countryCurrency.countryName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountryCurrency = filteredCountryCurrencies[indexPath.row]
        newCountry?.newCountrySelected(countryCurrency: selectedCountryCurrency)
        //searchController.isActive
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
}
