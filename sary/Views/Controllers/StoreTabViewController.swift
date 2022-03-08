//
//  StoreTabViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit
import RxSwift

class StoreTabViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    private var viewModel: StoreTabViewModel!
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
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
    
    var searchButton: SearchButton!
    var bannerView: BannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivity()
        
        viewModel.fetch()
            .subscribe(onCompleted:  {
                print("loaded")
                self.loaded()
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func configure(viewModel: StoreTabViewModel) {
        self.viewModel = viewModel
    }
    
    func loaded() {
        hideActivity()
        
        view.addSubview(mainStack)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
        
        searchButton = SearchButton(gesture: UITapGestureRecognizer(target: self, action:  #selector(searchButtonAction)))
        
        mainStack.addArrangedSubview(searchButton)
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
                let dynamicSmartView = DynamicSmartView(catalog: catalog)
                vstack.addArrangedSubview(dynamicSmartView)
            case .group:
                switch catalog.ui_type {
                case .grid:
                    let dynamicGroupGridView = DynamicGroupGridView(catalog: catalog)
                    vstack.addArrangedSubview(dynamicGroupGridView)
                case .linear:
                    let dynamicGroupLinearView = DynamicGroupLinearView(catalog: catalog)
                    vstack.addArrangedSubview(dynamicGroupLinearView)
                }
                
            case .banner:
                let dynamicBannerView = DynamicBannerView(catalog: catalog)
                vstack.addArrangedSubview(dynamicBannerView)
            case .sku:
                continue
            }
        }
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
