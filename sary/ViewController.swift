//
//  ViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit
import Alamofire

let BANNER_API = "https://staging.sary.co/api/v2.5.1/baskets/76097/banners/"
let CATALOG_API = "https://staging.sary.co/api/baskets/76097/catalog/"

let headers: HTTPHeaders = [
    "Device-Type": "ios",
    "App-Version": "3.1.1.0.0",
    "Accept-Language": "en",
    "Authorization": "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ODg2NiwidXNlcl9waG9uZSI6Ijk2NjU2NDk4OTI1MCJ9.VYE28vtnMRLmwBISgvvnhOmPuGueW49ogOhXm5ZqsGU"
]

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
//        AF.request(BANNER_API, headers: headers).responseDecodable(of: BannerAPIResult.self) { response in
//            debugPrint(response)
//        }
        
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


