//
//  ViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        title = "Store"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        let storeTab = StoreTabViewController()
        let storeTabBarItem = UITabBarItem(title: "Store", image: nil, tag: 0)
        storeTab.tabBarItem = storeTabBarItem
        
        let ordersTab = OrdersTabViewController()
        let ordersTabBarItem = UITabBarItem(title: "Orders", image: nil, tag: 1)
        ordersTab.tabBarItem = ordersTabBarItem
        
        let accountTab = AccountTabViewController()
        let accountTabBarItem = UITabBarItem(title: "Account", image: nil, tag: 2)
        accountTab.tabBarItem = accountTabBarItem
        
        viewControllers = [storeTab, ordersTab, accountTab]
    }
    
    
}

