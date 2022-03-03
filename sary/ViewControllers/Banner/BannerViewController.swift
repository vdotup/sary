//
//  BannerViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import UIKit

class BannerViewController: UIViewController {
    
    let label: UILabel = {
            let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = .white
        label.textAlignment = .center
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.anchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor, width: view.widthAnchor)
    }
    
}
