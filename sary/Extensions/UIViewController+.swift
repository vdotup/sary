//
//  ViewController+.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import UIKit


fileprivate var activityIndicator: UIActivityIndicatorView!
fileprivate var box: UIView!

extension UIViewController {

    func showActivity() {
        let boxSize: CGSize = .init(width: 100, height: 100)
        let boxPosition: CGPoint = .init(x: self.view.center.x - boxSize.width / 2, y: self.view.center.y - boxSize.height / 2)
        box = UIView(frame: .init(origin: boxPosition, size: boxSize))
        box.backgroundColor = .black
        box.alpha = 0.75
        box.layer.cornerRadius = 20
        view.addSubview(box)
        
        activityIndicator = UIActivityIndicatorView(frame: .init(origin: .zero, size: .init(width: 50, height: 50)))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false

    }

    func hideActivity() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        box.removeFromSuperview()
    }
    
}
