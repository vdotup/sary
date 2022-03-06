//
//  SearchButton.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class SearchButton: UIView {
    
    var icon: UIImageView!
    var label: UILabel!
    var configured: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        
        icon = UIImageView(image: UIImage(named: "mGlass"))
        icon.frame = CGRect(x: 0, y: 0, width: 16.7, height: 15)
        addSubview(icon)
        icon.anchor(leading: leadingAnchor, centerY: centerYAnchor)
        //icon.anchor(leading: leadingAnchor, centerY: centerYAnchor)
        
        label = UILabel()
        label.text = "ابحث عن اللي ناقصك"
        addSubview(label)
        
        label.anchor(leading: icon.trailingAnchor, centerY: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        anchor(heightConstant: 40)
        layer.cornerRadius = frame.height / 2
        print(frame, bounds, layer.frame, layer.bounds)
    }
    
    func configure(gesture: UITapGestureRecognizer) {
        if configured { return }
        addGestureRecognizer(gesture)
        configured = true
    }
    
}
