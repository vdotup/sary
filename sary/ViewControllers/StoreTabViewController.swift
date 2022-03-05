//
//  StoreTabViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit

class StoreTabViewController: UIViewController {
    
    let viewModel = StoreTabViewModel()
    
    let items: [CGFloat] = [
        160, 120, 400, 50, 300, 400, 200, 50
    ]
    
    var tableView: UITableView!
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.backgroundColor = .blue
        return stack
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let container: UIView = {
        let view = UIView()
        return view
    }()
    
    let vstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
    }()
    
    let bannerView: BannerView = {
        let view = BannerView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tableView = UITableView()
        //        tableView.dataSource = self
        //        tableView.delegate = self
        //        tableView.autoresizingMask = [.flexibleHeight]
        //        tableView.register(BannerCell.self, forCellReuseIdentifier: "BannerCell")
        //        tableView.register(SmartCell.self, forCellReuseIdentifier: "SmartCell")
        //        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
        //        tableView.separatorColor = .clear
        //        tableView.showsVerticalScrollIndicator = false
        //        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.estimatedRowHeight = 600
        //        vstack.addArrangedSubview(statsView)
        //        vstack.addArrangedSubview(productionView)
        //        vstack.addArrangedSubview(partnersView)
        //        vstack.addArrangedSubview(footerView)
        
        //                scrollView.anchor(top: view.topAnchor,
        //                                  leading: view.leadingAnchor,
        //                                  bottom: view.bottomAnchor,
        //                                  trailing: view.trailingAnchor
        //                )
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationItem.title = "Store"
        
        // - mainStack
        // - - searchBar
        // - - collectionView
        // - - - banner
        // - - - catalog
        // - - - catalog
        // - - - catalog
        
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: 25)
        )
        //view.addSubview(bannerPageVC.view)
        
        mainStack.addArrangedSubview(searchButton)
        mainStack.addArrangedSubview(scrollView)
        //mainStack.addArrangedSubview(tableView)
        scrollView.addSubview(container)
        container.addSubview(vstack)
        
        vstack.addArrangedSubview(bannerView)
        
        
        
        searchButton.anchor(top: mainStack.topAnchor, heightConstant: 40)
        
        container.anchor(top: scrollView.topAnchor,
                         leading: scrollView.leadingAnchor,
                         bottom: scrollView.bottomAnchor,
                         trailing: scrollView.trailingAnchor,
                         width: scrollView.widthAnchor
        )
        scrollView.contentInsetAdjustmentBehavior = .never
        vstack.anchor(top: scrollView.topAnchor,
                      leading: scrollView.leadingAnchor,
                      bottom: scrollView.bottomAnchor,
                      trailing: scrollView.trailingAnchor,
                      width: scrollView.widthAnchor
        )
        
        bannerView.configure(banners: viewModel.banners)
        
        for catalog in viewModel.catalogs {
            switch catalog.data_type {
            case .smart:
                let dynamicSmartView = DynamicSmartView()
                vstack.addArrangedSubview(dynamicSmartView)
                dynamicSmartView.configure(catalog: catalog)
            case .group:
                let dynamicGroupView = DynamicGroupView()
                vstack.addArrangedSubview(dynamicGroupView)
                dynamicGroupView.configure(catalog: catalog)
            case .banner:
                let dynamicBannerView = DynamicBannerView()
                vstack.addArrangedSubview(dynamicBannerView)
                dynamicBannerView.configure(catalog: catalog)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        //bannerPageVC.view.anchor(width: mainStack.widthAnchor , heightConstant: 160)
    }
    
    @objc private func searchButtonAction(sender: UIButton!) {
        print("SEARCH")
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

//extension StoreTabViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1 + 2
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
//            cell.configure(banners: viewModel.banners)
//            return cell
//        } else {
//            let catalog = viewModel.catalogs[indexPath.row - 1]
//
//            switch catalog.data_type {
//            case .smart:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "SmartCell", for: indexPath) as! SmartCell
//                cell.configure(catalog: catalog)
//                return cell
//
//            case .group:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
//                cell.configure(catalog: catalog)
//                return cell
//
//            case .banner:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "SmartCell", for: indexPath) as! SmartCell
//                cell.configure(catalog: catalog)
//                return cell
//            }
//        }
//
//    }
//
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        items[indexPath.row]
////    }
//
//    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
//        10
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//            return UITableView.automaticDimension
//        }
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return UITableView.automaticDimension
//        }
//
//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            cell.layoutIfNeeded()
//        }
//
//}


