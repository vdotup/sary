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
        160, 105, 200, 50, 300, 400, 200, 50
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BannerCell")
        tableView.register(DynamicUICell.self, forCellReuseIdentifier: "DynamicUICell")
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
        
        
        bannerPageVC.didMove(toParent: self)
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
        1 + viewModel.catalog.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath)
            cell.selectionStyle = .none
            cell.addSubview(bannerPageVC.view)
            bannerPageVC.view.fillSuperview()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DynamicUICell", for: indexPath) as! DynamicUICell
            cell.selectionStyle = .none
            cell.configure(catalog: viewModel.catalog[indexPath.row - 1])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        items[indexPath.row]
    }
    
}


