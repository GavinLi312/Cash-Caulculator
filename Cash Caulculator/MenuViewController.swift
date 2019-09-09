//
//  MenuViewController.swift
//  IncomeTracker
//
//  Created by Salamender Li on 20/7/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import UIKit

protocol MenuButtonClickedProtocol {
    func menuButtonClicked(option:menuButtons)
}

enum menuButtons{
    case countCash
    case share
    case save
    case checkHistory
}

class MenuViewController: UIViewController {
    
    let menu : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let menuButton:[UIButton] = {
        var buttonGroup : [UIButton] = []
        for choice in Constant.menuArray{
            var button = UIButton()
            button.setTitle(choice, for: .normal)
            button.setTitleColor(UIColor.fillcolor, for: .normal)
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonGroup.append(button)
            button.addTarget(self, action: #selector(buttonEvents(sender:)), for: .touchDown)
        }
        return buttonGroup
    }()
    
    var menuButtonClickedprotocol:MenuButtonClickedProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        setUpMenu()
        setupMenuButton()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.addTapGestureToView()
    }
    
    func setUpMenu() {
        self.view.addSubview(menu)
        // menu.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor, multiplier: 0.33).isActive = true
        menu.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        menu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        menu.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupMenuButton() {
        for button in menuButton{
            menu.addSubview(button)
            menu.bringSubviewToFront(button)
            button.widthAnchor.constraint(equalTo: menu.widthAnchor).isActive = true
            button.centerXAnchor.constraint(equalTo: self.menu.centerXAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            if button == menuButton.first{
                button.topAnchor.constraint(equalTo: self.menu.topAnchor,constant: 5).isActive = true
                button.addBorder(toSide: .Bottom, withColor: UIColor.strokeColor, andThickness: 0.5)
            }else if button != menuButton.last{
                button.addBorder(toSide: .Bottom, withColor: UIColor.strokeColor, andThickness: 0.5)
                let index = menuButton.firstIndex(of: button)!
                button.topAnchor.constraint(equalTo: menuButton[index - 1].bottomAnchor).isActive = true
                button.heightAnchor.constraint(equalTo: menuButton[index - 1].heightAnchor).isActive = true
                
            }else{
                button.topAnchor.constraint(equalTo: menuButton[menuButton.endIndex - 2].bottomAnchor, constant: 10).isActive = true
                button.bottomAnchor.constraint(equalTo: menu.bottomAnchor,constant: -5).isActive = true
            }
        }
    }
    
    @objc func buttonEvents(sender:UIButton)  {
        switch sender {
        case menuButton[0]:
            exit()
            self.menuButtonClickedprotocol?.menuButtonClicked(option: .countCash)
        case menuButton[1]:
            exit()
            self.menuButtonClickedprotocol?.menuButtonClicked(option: .share)
        case menuButton[2]:
            exit()
            self.menuButtonClickedprotocol?.menuButtonClicked(option: .save)
        case menuButton[3]:
            exit()
            self.menuButtonClickedprotocol?.menuButtonClicked(option: .checkHistory)
        case menuButton[4]:
            exit()
        default:
            print("should not happen")
        }
    }
    
    func addTapGestureToView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(exit))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func exit(){
        self.dismiss(animated: true, completion: nil)
    }
}
