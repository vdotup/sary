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
    
    var bannerView: BannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor, padding: .init(top: 10, left: 25, bottom: 0, right: 25)
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
        
        bannerView = BannerView(banners: viewModel.banners)
        vstack.addArrangedSubview(bannerView)
        
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
                let dynamicBannerView = DynamicBannerView(catalog: catalog)
                vstack.addArrangedSubview(dynamicBannerView)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationItem.title = "Store"
        
        let cartButton = UIButton(type: .custom)
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(cartButtonAction), for: .touchUpInside)
        cartButton.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let rightBarButton = UIBarButtonItem(customView: cartButton)
        
        let logoButton = UIButton(type: .custom)
        logoButton.setImage(UIImage(named: "logo"), for: .normal)
        logoButton.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let leftBarButton = UIBarButtonItem(customView: logoButton)
        
        let addressTitleView = AddressTitleView()
        
        tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
        tabBarController?.navigationItem.leftBarButtonItem = leftBarButton
        tabBarController?.navigationItem.titleView = addressTitleView
    }
    
    @objc private func searchButtonAction(sender: UITapGestureRecognizer) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc private func cartButtonAction() {
        let alert = UIAlertController(title: "سلة الشراء فارغة", message: "", preferredStyle: .alert)
        alert.addAction(.init(title: "موافق", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
