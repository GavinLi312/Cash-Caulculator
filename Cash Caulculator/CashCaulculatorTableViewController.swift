//
//  CashCaulculatorViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit

// myBarButtonItem to pass UITExtField
class myBarButtonItem: UIBarButtonItem {
    var passedUITextField:UITextField?
}


class CashCaulculatorTableViewController: UITableViewController,UITextFieldDelegate,NewCountrySelected{

    var country: String?
    
    var countryCurrency: CountryCurrency?
    
    var countryCurrencies: [CountryCurrency]?
    
    lazy var sectionHeaderViews : [Int:HeaderView] = [:]
    
    lazy var cashCaulculatorcells : [IndexPath: CashCaulculatorCell] = [:]
    
    lazy var textsForAlls:[IndexPath:String] = [:]
    
    override func viewDidLoad() {

        self.navigationController?.navigationBar.barTintColor = UIColor.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.fillcolor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.sectionHeaderHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.fillcolor
        self.view.backgroundColor = UIColor.backgroundColor
        let tableFooterView = TableFooterView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        tableFooterView.settotalValue(sign: self.countryCurrency!.sign, value: 0.0)
        tableView.tableFooterView = tableFooterView
        tableView.register(CashCaulculatorCell.self, forCellReuseIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: Constant.cashCaulculatorTableViewforFooterReuseIdentifier)
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigationControllerTitle(title: countryCurrency!.countryName)
        setNavigationItem()
    }
    
    func setNavigationControllerTitle(title: String){
        self.navigationItem.title = title
    }
    
    func setNavigationItem(){
        let cancelButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(cancelPressed(sender:)))
        let changeCurrencyButton = UIBarButtonItem(title: countryCurrency?.code, style: .plain, target: self, action: #selector(changeCurrency(sender:)))
        self.navigationItem.setRightBarButton(cancelButton, animated: false)
        self.navigationItem.setLeftBarButton(changeCurrencyButton, animated: false)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (countryCurrency?.bankNoteValue.count)!
        case 1:
            return (countryCurrency?.coinValue.count)!
        default:
            print("Should Not happen")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier, for: indexPath) as! CashCaulculatorCell
            cell.sign = countryCurrency?.sign
            cell.cellValue = Double((countryCurrency?.bankNoteValue[indexPath.row])!)
            if textsForAlls[indexPath] == nil{
                textsForAlls[indexPath] = ""
                cell.result = 0
            }else{
                
            }
//            if cell.result == nil{
//                cell.result = 0
//            }
            cell.noteNumberTextField.delegate = self
            self.cashCaulculatorcells[indexPath] = cell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier, for: indexPath) as! CashCaulculatorCell
            cell.sign = countryCurrency?.sign
            cell.cellValue = countryCurrency?.coinValue[indexPath.row]
            
            if textsForAlls[indexPath] == nil{
                textsForAlls[indexPath] = ""
                cell.result = 0
            }

//            if cell.result == nil{
//                cell.result = 0
//            }
            self.cashCaulculatorcells[indexPath] = cell
            cell.noteNumberTextField.delegate = self
            return cell
        default:
            print("Should not happen")
            return tableView.dequeueReusableCell(withIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier, for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func createToolBar(textField:UITextField){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = myBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed(sender:)))
        let previous =  myBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(previousPressed(sender:)))
        //(barButtonSystemItem: , target: self, action: #selector(cancelPressed))
        previous.passedUITextField = textField
        let next =  myBarButtonItem(title: "Next", style: .plain, target: self, action:  #selector(nextPressed(sender:)))
        next.passedUITextField = textField
        
        let space =  myBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        done.passedUITextField = textField
        toolbar.setItems([previous,next,space,done],animated:false)
        textField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed(sender:myBarButtonItem){
        textFieldDidEndEditing(sender.passedUITextField!)
        textFieldShouldReturn(sender.passedUITextField!)
    }
    
    @objc func cancelPressed(sender:myBarButtonItem?){
        for cell in cashCaulculatorcells.values{
            cell.noteNumberTextField.text  = ""
            cell.result = 0.0
        }
        for i in 0...tableView.numberOfSections-1{
            setfooterViewValue(i, 0)
        }
        setTableFooterViewValue()
    }
    
    @objc func previousPressed(sender:myBarButtonItem){
        let indexpath = self.findTextFieldIndexPath(textField: sender.passedUITextField as! CashCaulculatorTextField)
        guard let previousIndexPath = findPreviousIndexPath(indexpath: indexpath!) else{
            return
        }
        let previousCell = self.cashCaulculatorcells[previousIndexPath]
        textFieldDidEndEditing(sender.passedUITextField!)
        textFieldShouldReturn(sender.passedUITextField!)
        previousCell?.noteNumberTextField.becomeFirstResponder()
        tableView.selectRow(at: previousIndexPath, animated: true, scrollPosition: .none)
    }
    
    @objc func changeCurrency(sender:UIBarButtonItem) {
        
        let viewcontroller = ChangeCurrencyTableViewController()
        viewcontroller.countryCurrencies = self.countryCurrencies?.sorted(by: {
            $0.countryName < $1.countryName
        })
        
        viewcontroller.newCountry = self
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
    func findPreviousIndexPath(indexpath:IndexPath) -> IndexPath?{
        var indexpathSet = cashCaulculatorcells.keys.sorted {
            if $0.section != $1.section{
                return $0.section < $1.section
            }else{
                return $0.row < $1.row
            }
        }
        if indexpath == indexpathSet.first{
            return nil
        }else{
            let previousIndexPath = indexpathSet[indexpathSet.firstIndex(of: indexpath)! - 1]
            return previousIndexPath
        }
    }
    
    func findNextIndexPath(indexpath:IndexPath) -> IndexPath?{
        var indexpathSet = cashCaulculatorcells.keys.sorted {
            if $0.section != $1.section{
                return $0.section < $1.section
            }else{
                return $0.row < $1.row
            }
        }
        if indexpath == indexpathSet.last{
            return nil
        }else{
            let previousIndexPath = indexpathSet[indexpathSet.firstIndex(of: indexpath)! + 1]
            return previousIndexPath
        }
    }
    
    @objc func nextPressed(sender:myBarButtonItem) {
        let indexpath = self.findTextFieldIndexPath(textField: sender.passedUITextField as! CashCaulculatorTextField)
        guard let nextIndexPath = findNextIndexPath(indexpath: indexpath!) else{
            return
        }
        let nextCell = self.cashCaulculatorcells[nextIndexPath]
        textFieldDidEndEditing(sender.passedUITextField!)
        textFieldShouldReturn(sender.passedUITextField!)
        nextCell?.noteNumberTextField.becomeFirstResponder()
    }
    
    func findTextFieldIndexPath(textField:CashCaulculatorTextField) -> IndexPath?{
        guard let superview = textField.superview?.superview as? CashCaulculatorCell else {
            print("Error")
            return nil
        }
        
        guard let indexpath = tableView.indexPath(for: superview) else{
            print("error")
            return nil
        }
        
        return indexpath
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        createToolBar(textField: textField)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let superview = textField.superview?.superview as? CashCaulculatorCell else {
            print("error")
            return true
        }
        
        var text : String?
        switch range.length {
        case 0:
            text = "\(textField.text!)\(string)"
        case 1:
            var temp = textField.text
            temp?.popLast()
            text = temp
        default:
            print("should not happen")
        }

        if text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            text = "0"
        }
        
        if text!.count >= 6{
            return false
        }
        
        guard let _ = Double(text!) else {
            print("error")
            return false
        }
        
        superview.result = (round((Double(text!)!) * superview.cellValue!*100)/100)
        return true
    }
    
    fileprivate func setfooterViewValue(_ section: Int, _ result: Double) {
        // tableView
        let footerView = tableView.headerView(forSection: section) as! HeaderView
        footerView.settotalValue(sign: countryCurrency!.sign, value: result)
    }
    
    func setTableFooterViewValue(){
        var totalResult = 0.0
        for view in sectionHeaderViews.values{
            totalResult += view.value!
        }
        guard let tableFooterView = tableView.tableFooterView as? TableFooterView else {
            print("error")
            return
        }
        tableFooterView.settotalValue(sign: countryCurrency!.sign, value: totalResult)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            guard let num = Int(textField.text!) else { return}
            if num == 0{
                textField.text = ""
            }else{
                textField.text = "\(num)"
            }
        }
        guard let indexpath = self.findTextFieldIndexPath(textField: textField as! CashCaulculatorTextField) else{
            print("Error")
            return
        }
        
        var result = 0.0
        let numberOfRows =  tableView.numberOfRows(inSection: indexpath.section)
        for i in 0...numberOfRows - 1{
            let indexpath = IndexPath(row: i, section: indexpath.section)
            guard let counterCell = tableView.cellForRow(at: indexpath) as? CashCaulculatorCell else {
                print("error")
                return
            }
            result += counterCell.result!
        }
        result = round(result*100)/100
        textsForAlls[indexpath] = textField.text
        setfooterViewValue(indexpath.section, result)
        setTableFooterViewValue()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.cashCaulculatorTableViewforFooterReuseIdentifier) as! HeaderView
        sectionHeaderViews[section] = headerView
        
        if headerView.value == nil{
            headerView.settotalValue(sign: countryCurrency!.sign, value: 0)
        }
        switch section {
        case 0:
            headerView.setTitle(title: Constant.bankNoteValueKey)
        case 1:
            headerView.setTitle(title: Constant.coinValueKey)
        default:
            print("Should not happen")
        }
        return headerView
    }
    

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellView = cell as! CashCaulculatorCell
        if textsForAlls[indexPath] != nil{
            cellView.noteNumberTextField.text = textsForAlls[indexPath]
        }
        if cellView.noteNumberTextField.text == ""{
            cellView.result = 0.0
        }else{
            cellView.result = (cellView.cellValue!) * Double(cellView.noteNumberTextField.text!)!
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellView = cell as! CashCaulculatorCell
        if cellView.noteNumberTextField.isEditing{
            textFieldDidEndEditing(cellView.noteNumberTextField)
            textFieldShouldReturn(cellView.noteNumberTextField)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func newCountrySelected(countryCurrency: CountryCurrency) {
        self.countryCurrency = countryCurrency
        let userDefault = UserDefaults()
        userDefault.setValue(countryCurrency.countryName, forKey: Constant.userDefaultKey)
        cancelPressed(sender:nil )
        self.cashCaulculatorcells.removeAll()
        self.textsForAlls.removeAll()
        tableView.reloadData()
    }
    

}



extension UIView{
    func addConstraintsWithFormat(format:String,views:UIView...){
        var viewsDictionary = [String:AnyObject]()
        //purpose is just to make the index unique
        for (index,view) in views.enumerated(){
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


