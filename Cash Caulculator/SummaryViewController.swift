//
//  SumaryViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 6/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//some change

import Foundation
import UIKit

protocol CountCashDelegate {
    func countcashFinished(amount:Double)
}


class SummaryViewController: UIViewController, MenuButtonClickedProtocol,UITextFieldDelegate,CountCashDelegate{

    

    var countryCurrency: CountryCurrency?
    var countriesCurrency: [CountryCurrency] = []
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let timePicker = TimePicker()
    let datePicker = UIDatePicker()
    
    var textFields : [String:TextFieldHolderTextField] = [:]
    
    var dateTextHolder : TextFieldHolder = {
        var holder = TextFieldHolder()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.titleLabel.text = Constant.labelTitles[0]
        holder.textField.placeholder = NSDate().dateFormater()
        return holder
    }()
    
    var cashierSection : TextFieldHolderSecition = {
        var section = TextFieldHolderSecition()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.titleTextFieldHolder.titleLabel.text = Constant.labelTitles[1]
        section.titleTextFieldHolder.textField.placeholder = Constant.labelTitles[1]
        section.subtitleTextFieldHolder.titleLabel.text = Constant.labelTitles[2]
        section.subtitleTextFieldHolder.textField.placeholder = Constant.labelTitles[2]
        section.subtitleTextFieldHolder2.titleLabel.text = Constant.labelTitles [3]
        section.subtitleTextFieldHolder2.textField.placeholder = Constant.labelTitles[3]
        return section
    }()

    var accountReceivableTextHolder : TextFieldHolder = {
        var holder = TextFieldHolder()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.titleLabel.text = Constant.labelTitles[4]
        holder.textField.placeholder = Constant.labelTitles[4]
        return holder
    }()
    
    var discountTextHolder : TextFieldHolder = {
        var holder = TextFieldHolder()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.titleLabel.text = Constant.labelTitles[5]
        holder.textField.placeholder = Constant.labelTitles[5]
        return holder
    }()
    
    var proceedsSection : TextFieldHolderSecition = {
        var section = TextFieldHolderSecition()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.titleTextFieldHolder.titleLabel.text = Constant.labelTitles[6]
        section.titleTextFieldHolder.textField.placeholder = Constant.labelTitles[6]
        section.subtitleTextFieldHolder.titleLabel.text = Constant.labelTitles[7]
        section.subtitleTextFieldHolder.textField.placeholder = Constant.labelTitles[7]
        section.subtitleTextFieldHolder2.titleLabel.text = Constant.labelTitles [8]
        section.subtitleTextFieldHolder2.textField.placeholder = Constant.labelTitles[8]
        return section
    }()
    
    var actualAmountSection : TextFieldHolderSecition = {
        var section = TextFieldHolderSecition()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.titleTextFieldHolder.titleLabel.text = Constant.labelTitles[9]
        section.titleTextFieldHolder.textField.placeholder = Constant.labelTitles[9]
        section.subtitleTextFieldHolder.titleLabel.text = Constant.labelTitles[10]
        section.subtitleTextFieldHolder.textField.placeholder = Constant.labelTitles[10]
        section.subtitleTextFieldHolder2.titleLabel.text = Constant.labelTitles [11]
        section.subtitleTextFieldHolder2.textField.placeholder = Constant.labelTitles[11]
        return section
    }()
    
    var differenceSection : TextFieldHolderSecition = {
        var section = TextFieldHolderSecition()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.titleTextFieldHolder.titleLabel.text = Constant.labelTitles[12]
        section.titleTextFieldHolder.textField.placeholder = Constant.labelTitles[12]
        section.subtitleTextFieldHolder.titleLabel.text = Constant.labelTitles[13]
        section.subtitleTextFieldHolder.textField.placeholder = Constant.labelTitles[13]
        section.subtitleTextFieldHolder2.titleLabel.text = Constant.labelTitles [14]
        section.subtitleTextFieldHolder2.textField.placeholder = Constant.labelTitles[14]
        return section
    }()
    
    var reasonTextHolder : TextFieldHolder = {
        var holder = TextFieldHolder()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.titleLabel.text = Constant.labelTitles[15]
        holder.textField.placeholder = Constant.labelTitles[15]
        return holder
    }()
    
    
    override func viewDidLoad() {
        setNavigationBar()
        self.view.backgroundColor = UIColor.backgroundColor
        setupScrollView()
        addSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    override func viewDidDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Summary"
        let barbuttonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonClicked(sender:)))
        self.navigationItem.setRightBarButton(barbuttonItem, animated: false)
    }
    
    
    func addSubViews(){
    self.contentView.addSubview(dateTextHolder)
    self.contentView.addSubview(cashierSection)
    self.contentView.addSubview(accountReceivableTextHolder)
    self.contentView.addSubview(discountTextHolder)
    self.contentView.addSubview(proceedsSection)
    self.contentView.addSubview(actualAmountSection)
    self.contentView.addSubview(differenceSection)
    self.contentView.addSubview(reasonTextHolder)
        
    textFields[Constant.labelTitles[0]] = dateTextHolder.textField
    textFields[Constant.labelTitles[1]] = cashierSection.titleTextFieldHolder.textField
    textFields[Constant.labelTitles[2]] = cashierSection.subtitleTextFieldHolder.textField
    textFields[Constant.labelTitles[3]] = cashierSection.subtitleTextFieldHolder2.textField
    textFields[Constant.labelTitles[4]] = accountReceivableTextHolder.textField
    textFields[Constant.labelTitles[5]] = discountTextHolder.textField
    textFields[Constant.labelTitles[6]] = proceedsSection.titleTextFieldHolder.textField
    textFields[Constant.labelTitles[7]] = proceedsSection.subtitleTextFieldHolder.textField
    textFields[Constant.labelTitles[8]] = proceedsSection.subtitleTextFieldHolder2.textField
    textFields[Constant.labelTitles[9]] = actualAmountSection.titleTextFieldHolder.textField
    textFields[Constant.labelTitles[10]] = actualAmountSection.subtitleTextFieldHolder.textField
    textFields[Constant.labelTitles[11]] = actualAmountSection.subtitleTextFieldHolder2.textField
    textFields[Constant.labelTitles[12]] = differenceSection.titleTextFieldHolder.textField
    textFields[Constant.labelTitles[13]] = differenceSection.subtitleTextFieldHolder.textField
    textFields[Constant.labelTitles[14]] = differenceSection.subtitleTextFieldHolder2.textField
    textFields[Constant.labelTitles[15]] = reasonTextHolder.textField
        
    for item in textFields.values{
        item.delegate = self
    }

    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views:dateTextHolder)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: cashierSection)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: accountReceivableTextHolder)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: discountTextHolder)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: proceedsSection)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: actualAmountSection)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: differenceSection)
    contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: reasonTextHolder)
    contentView.addConstraintsWithFormat(format: "V:|[v0(>=50)][v1(>=100)][v2(v0)][v3(v0)][v4(v1)][v5(v4)][v6(v5)][v7(v0)]", views: dateTextHolder,cashierSection,accountReceivableTextHolder,discountTextHolder,proceedsSection,actualAmountSection,differenceSection,reasonTextHolder)
    contentView.bottomAnchor.constraint(equalTo: reasonTextHolder.bottomAnchor).isActive = true
    }
    
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    /// Bar button Clicked response event
    
    @objc func menuButtonClicked(sender:UIBarButtonItem){
        view.endEditing(true)
        let vc = MenuViewController()
        vc.menuButtonClickedprotocol = self
       // vc.addProfileImageProtocol = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func menuButtonClicked(option: menuButtons) {
        
        switch option {
        case .countCash:
            let calculatorCashViewController = CashCaulculatorTableViewController()
            calculatorCashViewController.countryCurrency = self.countryCurrency
            calculatorCashViewController.countryCurrencies = self.countriesCurrency
        self.navigationController?.pushViewController(calculatorCashViewController, animated: true)
        case .share:
            let image = captureScreenshot()
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        case .save:
            let image = captureScreenshot()
            let name = "\(NSDate().dateFormaterForName())\((textFields[Constant.labelTitles[1]]?.text!)! )"
            let fileHelper = FileHelper()
            fileHelper.saveImageWithName(image: image, name: name)
            let messageView = buildMessageView()
            self.view.addSubview(messageView)
            messageView.translatesAutoresizingMaskIntoConstraints = false
            var constraints : [NSLayoutConstraint] = []
            let centerXConstraint = NSLayoutConstraint(item: messageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            let centerYConstraint = NSLayoutConstraint(item: messageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            let heightAnchor = NSLayoutConstraint(item: messageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
            let widthAnchor = NSLayoutConstraint(item: messageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 200)
            constraints.append(centerXConstraint)
            constraints.append(centerYConstraint)
            constraints.append(heightAnchor)
            constraints.append(widthAnchor)
            NSLayoutConstraint.activate(constraints)
            _ = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { (Timer) in
                messageView.removeFromSuperview()
                NSLayoutConstraint.deactivate(constraints)
            }
        case .checkHistory:
            let vc = CheckHistoryTabkeViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /// Capture screen shot
    func captureScreenshot() -> UIImage{
        let layer = self.contentView.layer
        let scale = UIScreen.main.scale
        // Creates UIImage of same size as view
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot!
    }
    
    //MARK: - TextFieldDelegate Methods
    ///TextField SHould begin Editing
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTextHolder.textField{
            createDatePicker(textField: textField)
        }else if textField == cashierSection.subtitleTextFieldHolder.textField{
            createTimePicker(textField: textField)
        }else if textField == cashierSection.subtitleTextFieldHolder2.textField {
            createTimePicker(textField: textField)
        }else if textField != cashierSection.titleTextFieldHolder.textField && textField != reasonTextHolder.textField{
            createToolBar(textField:textField)
        }

        if [actualAmountSection.titleTextFieldHolder.textField, differenceSection.titleTextFieldHolder.textField,differenceSection.subtitleTextFieldHolder.textField,differenceSection.subtitleTextFieldHolder2.textField].contains(textField){
            return false
        }

        return true
    }
    
    
    ///textField Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //calculate the sum
        if textField == textFields[Constant.labelTitles[10]] || textField == textFields[Constant.labelTitles[11]]{
            calculateSumofTwoTextField(factor1:textFields[Constant.labelTitles[10]]! , factor2: textFields[Constant.labelTitles[11]]!, result: textFields[Constant.labelTitles[9]]!)
        }
        
        let firstDeductionGroup = [textFields[Constant.labelTitles[9]],textFields[Constant.labelTitles[6]]]
        //deduction
        if firstDeductionGroup.contains((textField as! TextFieldHolderTextField)){
            calculateDifferenceOfTwoTextField(factor1: firstDeductionGroup[0]!, factor2: firstDeductionGroup[1]!, result: textFields[Constant.labelTitles[12]]!)
        }
        
        let secondDeductionGroup = [textFields[Constant.labelTitles[10]],textFields[Constant.labelTitles[7]]]
        if secondDeductionGroup.contains((textField as! TextFieldHolderTextField)){
            calculateDifferenceOfTwoTextField(factor1: secondDeductionGroup[0]!, factor2: secondDeductionGroup[1]!, result: textFields[Constant.labelTitles[13]]!)
        }
        
        let thirdGroup = [textFields[Constant.labelTitles[11]],textFields[Constant.labelTitles[8]]]
        
        if thirdGroup.contains((textField as! TextFieldHolderTextField)){
            calculateDifferenceOfTwoTextField(factor1: thirdGroup[0]!, factor2: thirdGroup[1]!, result: textFields[Constant.labelTitles[14]]!)
        }
    }
    
    func createTimePicker(textField:UITextField){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = myBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed(sender:)))
        done.passedUITextField = textField
        toolbar.setItems([done],animated:false)
        textField.inputAccessoryView = toolbar
        textField.inputView = timePicker
    }
    
    func createDatePicker(textField:UITextField) {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = myBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDonePressed(sender:)))
        done.passedUITextField = textField
        toolbar.setItems([done],animated:false)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    func createToolBar(textField:UITextField){
        textField.keyboardType = .decimalPad
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = myBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))
        done.passedUITextField = textField
        if textField == textFields[Constant.labelTitles[10]]{
            let count = myBarButtonItem(title: "Count", style: .plain, target: self, action: #selector(countCashPressed(sender:)) )
            count.passedUITextField = textField
            let space =  myBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolbar.setItems([done,space,count], animated: false)
        }else{
            toolbar.setItems([done],animated:false)
        }
        
        textField.inputAccessoryView = toolbar
    }
    
    
    /// bunton functions
    @objc func donePressed(sender:myBarButtonItem){
        let textField = sender.passedUITextField!
        let minute:String
        if timePicker.minute < 10{
            minute = "0\(timePicker.minute )"
        }else{
            minute = "\(timePicker.minute )"
        }
        textField.text = "\(timePicker.hour) : \(minute)"
        textField.resignFirstResponder()
    }
    
    @objc func datePickerDonePressed(sender:myBarButtonItem){
        let textField = sender.passedUITextField!
        textField.text = NSDate(date: datePicker.date).dateFormater()
        textField.resignFirstResponder()
    }
    
    
    @objc func doneButtonPressed(sender:myBarButtonItem){
        textFieldShouldReturn(sender.passedUITextField!)
    }
    
    @objc func countCashPressed(sender:myBarButtonItem){
        textFieldShouldReturn(sender.passedUITextField!)
        let calculatorCashViewController = CashCaulculatorTableViewController()
        calculatorCashViewController.countryCurrency = self.countryCurrency
        calculatorCashViewController.countryCurrencies = self.countriesCurrency
        calculatorCashViewController.countcashDelegate = self
        self.navigationController?.pushViewController(calculatorCashViewController, animated: true)
    }
    
    /// keyboard methods keyboard will show
    override func keyboardWillShow(_ notification: Notification) {
        
        let firstResponsider = textFields.values.filter { (field) -> Bool in
            field.isFirstResponder == true
        }[0]
        
        var superview : UIView?
        if firstResponsider.superview?.superview?.superview?.superview == self.contentView{
            superview = firstResponsider.superview?.superview?.superview
        }else  if firstResponsider.superview?.superview?.superview == self.contentView{
            superview = firstResponsider.superview?.superview
        }else if firstResponsider.superview?.superview == self.contentView{
             superview = firstResponsider.superview
        }
        let keyboardTop = self.contentView.frame.maxY - getKeyboardHeight(notification: notification)
        let textFieldBottom = superview?.frame.maxY
        
        if textFieldBottom! > keyboardTop{
            view.frame.origin.y = (self.navigationController?.navigationBar.frame.maxY)! - (textFieldBottom! - keyboardTop)
        }
    }
    
    /// keyboard methods keyboard will disappear
    override func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = (self.navigationController?.navigationBar.frame.maxY)!
    }

    
    func countcashFinished(amount:Double) {
        let textField = textFields[Constant.labelTitles[10]]
        textField!.text = "\(amount)"
    }
    
    //MARK: - Calculation
    
    /// calculate the sum of two text fields
    func calculateSumofTwoTextField(factor1: TextFieldHolderTextField,factor2:TextFieldHolderTextField,result:TextFieldHolderTextField){
        let factor1text = factor1.text
        let factor2text = factor2.text
        
        if factor1text == "" && factor2text == ""{
            return
        }else if factor1text == ""{
            result.text = factor2text
        }else if factor2text == ""{
            result.text = factor1text
        }else{
            result.text = "\(Double(factor1text!)! + Double(factor2text!)!)"
        }
        textFieldDidEndEditing(result)
    }
    
    
    /// deduction of ToTextFields factor1 will be reduced by factor2
    func calculateDifferenceOfTwoTextField(factor1: TextFieldHolderTextField,factor2:TextFieldHolderTextField,result:TextFieldHolderTextField){
        let factor1text = factor1.text
        let factor2text = factor2.text
        if factor1text == "" && factor2text == ""{
            return
        }else if factor1text == ""{
            result.text = "\(-Double(factor2text!)!)"
        }else if factor2text == ""{
            result.text = factor1text
        }else{
            result.text = "\(Double(factor1text!)! - Double(factor2text!)!)"
        }
        textFieldDidEndEditing(result)
    }
    
    
    /// build Message View
    func buildMessageView() -> UIView{
        let label = CashCaulculatorLabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Save Success!"
        label.contentMode = .scaleAspectFill
        let messageView = UIView()
        messageView.backgroundColor = UIColor.gray.withAlphaComponent(0.75)
        messageView.layer.cornerRadius = 10
        messageView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        messageView.addConstraintsWithFormat(format: "H:|[v0]|", views: label)
        messageView.addConstraintsWithFormat(format: "V:|[v0]|", views: label)
        return messageView
    }

}
