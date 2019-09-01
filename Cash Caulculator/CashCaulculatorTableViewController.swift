//
//  CashCaulculatorViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit
class CashCaulculatorTableViewController: UITableViewController,UITextFieldDelegate{
    
    var country: String?
    
    var countryCurrency: CountryCurrency?
    
    var countryCurrencies: [CountryCurrency]?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.tableView.sectionHeaderHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CashCaulculatorCell.self, forCellReuseIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigationControllerTitle(title: countryCurrency!.code)
    }
    
    func setNavigationControllerTitle(title: String){
        self.navigationItem.title = title
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return Constant.bankNoteValueKey
        case 1:
            return Constant.coinValueKey
        default:
            print("should not happen ")
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier, for: indexPath) as! CashCaulculatorCell
            cell.sign = countryCurrency?.bankNoteSign
            cell.cellValue = Double((countryCurrency?.bankNoteValue[indexPath.row])!)
            cell.noteNumberTextField.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cashCaulculatorTableViewforCellReuseIdentifier, for: indexPath) as! CashCaulculatorCell
            cell.sign = countryCurrency?.coinSign
            cell.cellValue = countryCurrency?.coinValue[indexPath.row]
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let superview = textField.superview?.superview as? CashCaulculatorCell else {
            print("error")
            return true
        }
//        let value =  as? Double
//        guard let value = superview.cellValue as? Double else {
//            print("error")
//            return true
//        }
        superview.Result = (Double("\(textField.text!)\(string)")!) * superview.cellValue!
        print("\(textField.text!)\(string)")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

class CashCaulculatorCell: UITableViewCell{

    
    var signLabel : CashCaulculatorLabel = {
        var label = CashCaulculatorLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.right
        return label
    }()

    var sign:String?
    
    var cellValue : Double?{
        didSet{
            changeSignLabel(sign: self.sign!, value: cellValue!)
        }
    }
    
    var Result : Double?{
        didSet{
            changeResultLabel(sign: self.sign!, value: Result!)
        }
    }
    
    var noteNumberTextField : CashCaulculatorTextField = {
        var textField = CashCaulculatorTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = ""
        return textField
    }()
    
    
    var resultLabel : CashCaulculatorLabel = {
        var label = CashCaulculatorLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "= 0"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addviews()
    }
    
    func addviews(){
        self.contentView.addSubview(signLabel)
        self.contentView.addSubview(noteNumberTextField)
        
        self.contentView.addSubview(resultLabel)
        
        contentView.addConstraintsWithFormat(format: "H:|-8-[v0(v2)]-8-[v1(150)]-8-[v2]-8-|", views: signLabel,noteNumberTextField,resultLabel)
        contentView.addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: signLabel)
        contentView.addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: noteNumberTextField)
        contentView.addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: resultLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeSignLabel(sign:String, value:Any){
        signLabel.text = "\(sign)\(value) X"
    }
    
    func changeResultLabel(sign:String,value:Double) {
        resultLabel.text = "= \(sign)\(value)"
    }
    
//    func textChange(string:String) {
//        <#code#>
//    }
    
}


class CashCaulculatorLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.gray
        self.sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//protocol textChangeProtocol {
//    func textChange(string:String)
//}

class CashCaulculatorTextField: UITextField {
    

    
    override var text: String?{
        didSet{
//            if text != ""{
//                textChangeProtocol?.textChange(string: text!)
//            }else{
//                textChangeProtocol?.textChange(string: "")
//            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.textAlignment = NSTextAlignment.center
        self.keyboardType = .numberPad
        self.placeholder = "0"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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



