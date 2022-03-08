//
//  SearchButton.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class SearchButton: UIView {
    
    var container: UIView!
    var icon: UIImageView!
    var label: UILabel!
    
    init(gesture: UITapGestureRecognizer) {
        super.init(frame: .zero)
        
        container = UIView()
        container.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        addSubview(container)
        container.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 25, bottom: 0, right: 25))
        
        
        icon = UIImageView(image: UIImage(named: "mGlass"))
        icon.frame = CGRect(x: 0, y: 0, width: 16.7, height: 15)
        container.addSubview(icon)
        icon.anchor(leading: container.leadingAnchor, centerY: container.centerYAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        label = UILabel()
        label.text = "ابحث عن اللي ناقصك"
        label.font = UIFont(name: "Almarai-Regular", size: 14)
        container.addSubview(label)
        label.anchor(leading: icon.trailingAnchor, centerY: container.centerYAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        setup(gesture: gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        
        container.anchor(heightConstant: 40)
        container.layer.cornerRadius = frame.height / 2
    }
    
    func setup(gesture: UITapGestureRecognizer) {
        addGestureRecognizer(gesture)
    }
    
}
