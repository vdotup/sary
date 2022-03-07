//
//  AddressTitleView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 06/03/2022.
//

import Foundation
import UIKit

class AddressTitleView: UIView {
    
    var icon: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //layer.cornerRadius = frame.height / 2
        
        icon = UIImageView(image: UIImage(named: "chevronDown"))
        icon.frame = CGRect(x: 0, y: 0, width: 10, height: 6)
        addSubview(icon)
        icon.anchor(leading: leadingAnchor, centerY: centerYAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))

        label = UILabel()
        label.text = "بقالة الأمانة"
        label.font = UIFont(name: "Almarai-Bold", size: 14)
        addSubview(label)

        label.anchor(leading: icon.trailingAnchor, centerY: centerYAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        anchor(heightConstant: 30)
        anchor(widthConstant: 120)
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        layer.cornerRadius = frame.height / 2
    }
    
}
