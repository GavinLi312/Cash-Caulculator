//
//  TextFieldHolder.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 6/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit

class TextFieldHolder: UIView{
    
    var titleLabel =  TextFieldHolderLabel()
    
    var textField = TextFieldHolderTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBorder(toSide: .Bottom, withColor: UIColor.strokeColor, andThickness: 0.5)
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        addUIElements()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIElements(){
        addSubview(titleLabel)
        addSubview(textField)
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: textField)
        addConstraintsWithFormat(format: "H:|-8-[v0]-[v1(==v0)]-8-|", views: titleLabel,textField)
    }
    
}

class TextFieldHolderSecition:UIView{
    
    var holderView = UIView()
    
    var titleTextFieldHolder = TextFieldHolder()
    
    var subtitleTextFieldHolder = TextFieldHolder()
    
    var subtitleTextFieldHolder2 = TextFieldHolder()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        addUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIElements(){
        holderView.translatesAutoresizingMaskIntoConstraints = false
        titleTextFieldHolder.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(subtitleTextFieldHolder)
        holderView.addSubview(subtitleTextFieldHolder2)
        holderView.addConstraintsWithFormat(format: "V:|[v0]|", views: subtitleTextFieldHolder)
        holderView.addConstraintsWithFormat(format: "V:|[v0]|", views: subtitleTextFieldHolder2)
        holderView.addConstraintsWithFormat(format: "H:|[v0(v1)][v1]|", views: subtitleTextFieldHolder,subtitleTextFieldHolder2)
        addSubview(titleTextFieldHolder)
        addSubview(holderView)
        addConstraintsWithFormat(format: "V:|[v0(v1)][v1]|", views: titleTextFieldHolder,holderView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleTextFieldHolder)
        addConstraintsWithFormat(format: "H:|[v0]|", views: holderView)

    }
}

class TextFieldHolderLabel:UILabel{
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.fillcolor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TextFieldHolderTextField:UITextField {
    
    var sibling : [TextFieldHolderTextField] = []
    
    var parent : [TextFieldHolderTextField] = []
    
    var child : [TextFieldHolderTextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 20)
        self.adjustsFontSizeToFitWidth = true
        self.contentVerticalAlignment = .center
        self.keyboardType = .default
        self.isEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.black
        self.clearButtonMode = .whileEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


