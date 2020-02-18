//
//  TintTextField.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 16/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class TintTextField: UITextField {

    var tintedClearImage: UIImage?
    let overlayButton = UIButton(type: .custom)
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       self.setupTintColor()
     }

     override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTintColor()
     }

     func setupTintColor() {
        self.borderStyle = UITextField.BorderStyle.roundedRect
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = .clear
        self.textColor = self.tintColor
        
        let image = tintImage(image: UIImage(systemName: "multiply")!, color: .white)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.backgroundColor = .clear
        
        overlayButton.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 14, height: 14))
        overlayButton.setImage(image, for: .normal)
        overlayButton.layer.cornerRadius = overlayButton.bounds.width/2
        overlayButton.backgroundColor = self.tintColor
        view.addSubview(overlayButton)
        
        
        overlayButton.center = view.center
                
        self.rightView = view;
        self.rightViewMode = .always
     }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    private func tintImage(image: UIImage, color: UIColor) -> UIImage {
        let size = image.size
        var newImage: UIImage?
        
        newImage = image.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        color.set()
        newImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .darken, alpha: 1)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
 }
