//
//  FilterValueView.swift
//  AwardTest
//
//  Created by Nico Prasasty S on 17/02/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

@IBDesignable /*if use Designgable*/
class FilterValueView: UIView {
    var label = UILabel()
    var imageView: UIImageView = UIImageView()
    
    @IBInspectable var image: UIImage = UIImage(){
        didSet{
            imageView.image = image
        }
    }
    
    @IBInspectable var text: String = ""{
        didSet{
            label.text = text
        }
    }
    
    @IBInspectable var textColor: UIColor = .black{
        didSet{
            label.textColor = textColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1{
        didSet{
            self.layer.borderWidth = lineWidth
        }
    }
    
    override var tintColor: UIColor!{
        didSet{
            self.layer.borderColor = self.tintColor.cgColor
            label.textColor = self.tintColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        self.layer.borderColor = self.tintColor.cgColor
        
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.alignment = .fill
        stackV.distribution = .fill
        self.addSubview(stackV)
        let contrain = [
            self.trailingAnchor.constraint(equalTo: stackV.trailingAnchor, constant: 5),
            self.topAnchor.constraint(equalTo: stackV.topAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: stackV.leadingAnchor, constant: -5),
            self.bottomAnchor.constraint(equalTo: stackV.bottomAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(contrain)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = self.tintColor
        label.sizeToFit()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        let imageViewConstrain = [
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(imageViewConstrain)
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(imageView)
        
        stackV.addArrangedSubview(stack)
    }
}

