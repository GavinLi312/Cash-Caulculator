//
//  ViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import UIKit

//delegate
protocol firebaseLoadingFinish {
   func  firebaseLoadingFinish()
}

class LoadingViewController: UIViewController, firebaseLoadingFinish{

    let loadinglabel : UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.textColor = UIColor.backgroundColor
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    let shapeLayer = CAShapeLayer()
    
    let pulsatingLayer =  CAShapeLayer()
    
    let trackLayer = CAShapeLayer()
    
    let firebaseHelper = FirebaseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(loadinglabel)
        firebaseHelper.loadingFinish = self

        
    }
    
    
    override func viewWillLayoutSubviews() {
        initializeCircleView(position: view.center)
        animateShapeLayer()
        animatePulsatingLayer()
        loadinglabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        loadinglabel.center = view.center
        view.bringSubviewToFront(loadinglabel)
    }
    
    func firebaseLoadingFinish() {
        let country = readUserDefaultCountry()
        let summaryViewController = SummaryViewController()

        let currency = firebaseHelper.countriesCurrency?.filter({
            $0.countryName == country
        })
        summaryViewController.countryCurrency = currency?.first
        summaryViewController.countriesCurrency = firebaseHelper.countriesCurrency!
        
        let navigationController = UINavigationController(rootViewController: summaryViewController)
        navigationController.navigationBar.barTintColor = UIColor.backgroundColor
        navigationController.navigationBar.tintColor = UIColor.fillcolor
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = false
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

    ///Progress Circle
    //https://www.youtube.com/watch?v=O3ltwjDJaMk
    func initializeCircleView(position: CGPoint) {
        
        
        let width = (self.view.frame.width < self.view.frame.height) ? self.view.frame.width/3 : self.view.frame.height/3
        let circlarPath = UIBezierPath(arcCenter: .zero, radius: width, startAngle: 0, endAngle: 2.0*CGFloat.pi, clockwise: true)
        pulsatingLayer.path = circlarPath.cgPath
        
        pulsatingLayer.lineWidth = 35
        
        pulsatingLayer.fillColor = UIColor.shapeLayerColor.withAlphaComponent(0.4).cgColor
        
        pulsatingLayer.lineCap = CAShapeLayerLineCap.round

        pulsatingLayer.position = position
        
        if view.layer.sublayers!.contains(pulsatingLayer) == false{
            view.layer.addSublayer(pulsatingLayer)
        }
        trackLayer.path = circlarPath.cgPath
        
        trackLayer.strokeColor =  UIColor.strokeColor.cgColor
        trackLayer.lineWidth = 35
        
        trackLayer.fillColor = UIColor.fillcolor.cgColor
        
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position = position
        
        trackLayer.shadowOffset = CGSize(width: 0, height: 5)
        trackLayer.shadowRadius = 5
        trackLayer.shadowOpacity = 0.3
        trackLayer.shadowColor = UIColor.lightGray.cgColor
        
        if view.layer.sublayers!.contains(trackLayer) == false{
            view.layer.addSublayer(trackLayer)
        }
        shapeLayer.path = circlarPath.cgPath
        
        shapeLayer.strokeColor = UIColor.shapeLayerColor.cgColor
        shapeLayer.lineWidth = 35
        shapeLayer.borderColor = UIColor.black.cgColor
        shapeLayer.borderWidth = 1
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = position
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        if view.layer.sublayers!.contains(shapeLayer) == false{
            view.layer.addSublayer(shapeLayer)
        }
    }
    
    func animatePulsatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.9
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        if pulsatingLayer.animation(forKey: "pulsating") == nil{
        pulsatingLayer.add(animation, forKey: "pulsating")
        }
    }
    
    func animateShapeLayer(){
        let basicAnimation =  CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        basicAnimation.repeatCount = Float.infinity
        if shapeLayer.animation(forKey: "shapeLaype") == nil {
        shapeLayer.add(basicAnimation, forKey: "shapeLaype")
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
    }
}

