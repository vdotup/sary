//
//  ViewController+.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import UIKit


fileprivate var activityIndicator: UIActivityIndicatorView!
fileprivate var greyView: UIView!

extension UIViewController {

    func showActivity() {
        activityIndicator = UIActivityIndicatorView(frame: .init(origin: .zero, size: .init(width: 50, height: 50)))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false

        greyView = UIView(frame: .init(origin: .zero, size: view.bounds.size))
        greyView.backgroundColor = .black
        greyView.alpha = 0.5
        view.addSubview(greyView)
    }

    func hideActivity() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        greyView.removeFromSuperview()
    }
    
}
