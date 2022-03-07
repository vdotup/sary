//
//  RootCoordinator.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import UIKit

class AppCoordinator {
    
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let storeTab = StoreTabViewController()
        storeTab.configure(viewModel: StoreTabViewModel())
        let storeTabBarItem = UITabBarItem(title: "المتجر", image: UIImage(named: "store"), tag: 0)
        storeTab.tabBarItem = storeTabBarItem
        
        let ordersTab = OrdersTabViewController()
        let ordersTabBarItem = UITabBarItem(title: "الطلبات", image: UIImage(named: "orders"), tag: 1)
        ordersTab.tabBarItem = ordersTabBarItem
        
        let accountTab = AccountTabViewController()
        let accountTabBarItem = UITabBarItem(title: "صفحتي", image: UIImage(named: "account"), tag: 2)
        accountTab.tabBarItem = accountTabBarItem
        
        tabBarController.configure(viewModel: TabBarViewModel(), tabs: [storeTab, ordersTab, accountTab])
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
