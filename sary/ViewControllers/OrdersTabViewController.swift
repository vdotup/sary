//
//  OrdersTabViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//


import UIKit

class OrdersTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Orders"
    }
 
}