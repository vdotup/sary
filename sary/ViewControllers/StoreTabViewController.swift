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
        160, 100, 500, 50, 300, 400, 200, 50
    ]
    
    var tableView: UITableView!
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        stack.distribution = .fill
        stack.backgroundColor = .blue
        return stack
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
    }()
    
    var bannerPageVC: BannerPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BannerCell.self, forCellReuseIdentifier: "BannerCell")
        tableView.register(SmartCell.self, forCellReuseIdentifier: "SmartCell")
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.separatorColor = .clear
        tableView.backgroundColor = .brown
        //tableView.register(CatalogDynamicUICell.self, forCellWithReuseIdentifier: "CatalogDynamicCell")
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
        
        bannerPageVC = BannerPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        view.addSubview(mainStack)
        //view.addSubview(bannerPageVC.view)
        
        mainStack.addArrangedSubview(searchButton)
        mainStack.addArrangedSubview(tableView)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor, padding: .init(top: 24, left: 25, bottom: 22, right: 25)
        )
        
        searchButton.anchor(top: mainStack.topAnchor, heightConstant: 40)
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

extension StoreTabViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 + 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.configure(banners: viewModel.banners)
            return cell
        } else {
            let catalog = viewModel.catalogs[indexPath.row - 1]
            
            switch catalog.data_type {
            case .smart:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SmartCell", for: indexPath) as! SmartCell
                cell.configure(catalog: catalog)
                return cell
                
            case .group:
                let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
                cell.configure(catalog: catalog)
                return cell
                
//                let cell = UITableViewCell()
//                return cell
            case .banner:
                
                print("banner??")
                let cell = tableView.dequeueReusableCell(withIdentifier: "SmartCell", for: indexPath) as! SmartCell
                cell.configure(catalog: catalog)
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        items[indexPath.row]
    }
    
}


