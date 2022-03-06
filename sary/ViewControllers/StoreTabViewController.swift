//
//  StoreTabViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit

class StoreTabViewController: UIViewController {
    
    let viewModel = StoreTabViewModel()
    
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
    
    let searchButton: SearchButton = {
        let button = SearchButton()
        return button
    }()
    
    let bannerView: BannerView = {
        let view = BannerView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: 25)
        )
        
        mainStack.addArrangedSubview(searchButton)
        searchButton.configure(gesture: UITapGestureRecognizer(target: self, action:  #selector(searchButtonAction)))
        mainStack.addArrangedSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(vstack)
        
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
        
        vstack.addArrangedSubview(bannerView)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationItem.title = "Store"
    }
    
    @objc private func searchButtonAction(sender: UITapGestureRecognizer) {
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


