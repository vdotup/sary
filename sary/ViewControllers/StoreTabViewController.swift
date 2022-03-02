//
//  StoreTabViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit

class StoreTabViewController: UIViewController {
    
    let items: [CGFloat] = [
        160, 50, 50, 50, 300, 400, 200, 50
    ]
    
    var collectionView: UICollectionView!
    
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
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        view.addSubview(bannerPageVC.view)
        
        mainStack.addArrangedSubview(searchButton)
        mainStack.addArrangedSubview(collectionView)

        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor, padding: .init(top: 24, left: 25, bottom: 22, right: 25)
        )
        
        searchButton.anchor(top: mainStack.topAnchor, heightConstant: 40)
        
        
        bannerPageVC.didMove(toParent: self)
    }
    
    override func viewWillLayoutSubviews() {
        bannerPageVC.view.anchor(width: mainStack.widthAnchor , heightConstant: 160)
    }
    
    @objc private func searchButtonAction(sender: UIButton!) {
        print("SEARCH")
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

extension StoreTabViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.addSubview(bannerPageVC.view)
        } else {
            cell.backgroundColor = UIColor.blue
        }
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = items[indexPath.row]
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    
}

