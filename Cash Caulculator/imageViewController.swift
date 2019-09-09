//
//  imageViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 8/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController : UIViewController{
    
    var shareButton : UIButton = {
        let button = UIButton()
        button.setTitle("share", for: .normal)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var image : UIImage?{
        didSet{
            imageView.image = image
            imageView.backgroundColor = .clear
        }
    }
    var imageView = UIImageView()
    
     var imageViewBottomConstraint: NSLayoutConstraint!
     var imageViewLeadingConstraint: NSLayoutConstraint!
     var imageViewTopConstraint: NSLayoutConstraint!
     var imageViewTrailingConstraint: NSLayoutConstraint!
    var imageViewCenterXConstraint:NSLayoutConstraint!
    var imageViewCenterYConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        self.view.backgroundColor = .black
        setupImageViewConstraints()
        addTapGestureToView()
        setupShareButton()
    }

    func setupImageViewConstraints() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        var constraints : [NSLayoutConstraint] = []
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewTopConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
       imageViewBottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
       imageViewLeadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
       imageViewTrailingConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        imageViewCenterXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        imageViewCenterYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        constraints.append(imageViewTrailingConstraint)
        constraints.append(imageViewBottomConstraint)
        constraints.append(imageViewLeadingConstraint)
        constraints.append(imageViewTrailingConstraint)
        constraints.append(imageViewCenterXConstraint)
        constraints.append(imageViewCenterYConstraint)
        NSLayoutConstraint.activate(constraints)
    }
    

    func addTapGestureToView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(exit))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func exit(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupImageView(){
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        viewWillLayoutSubviews()
    }
    
    func setupShareButton(){
        self.view.addSubview(shareButton)
        view.addConstraintsWithFormat(format: "H:[v0(80)]-|", views: shareButton)
        view.addConstraintsWithFormat(format: "V:|-[v0(50)]", views: shareButton)
        shareButton.addTarget(self, action: #selector(shareButtomClicked(sender: )), for:.touchDown )
    }

    @objc func shareButtomClicked(sender:UIButton){
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}
