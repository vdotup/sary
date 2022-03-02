//
//  StoreTabViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit

class StoreTabViewController: UIViewController {
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.backgroundColor = .blue
        return stack
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .yellow
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    let scrollContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    let scrollStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.backgroundColor = .green
        return stack
    }()
    
    let searchBar: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    let bannerBar: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let banner2Bar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationItem.title = "Store"
        
        // - mainStack
        // - - searchBar
        // - - scrollView
        // - - - banner
        // - - - catalog
        // - - - catalog
        
        view.addSubview(mainStack)
        
        //scrollStack.addArrangedSubview(banner)
        //scrollStack.addArrangedSubview(banner)
        
        //mainStack.addArrangedSubview(bannerBar)
        mainStack.addArrangedSubview(searchBar)
        mainStack.addArrangedSubview(scrollView)
        //mainStack.addArrangedSubview(scrollView)
        
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubview(scrollStack)
        
        scrollStack.addArrangedSubview(bannerBar)
        scrollStack.addArrangedSubview(banner2Bar)
        
        
        //searchBar.anchor(top: searchBar.bottomAnchor, bottom: mainStack.bottomAnchor)
        
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor
        )
        
        searchBar.anchor(top: mainStack.topAnchor, heightConstant: 50)
        
        scrollView.anchor(top: searchBar.bottomAnchor,
                                 leading: mainStack.leadingAnchor,
                                 bottom: mainStack.bottomAnchor,
                                 trailing: mainStack.trailingAnchor
               )
        
        scrollContainer.anchor(top: scrollView.bottomAnchor,
                         leading: scrollView.leadingAnchor,
                         bottom: scrollView.bottomAnchor,
                         trailing: scrollView.trailingAnchor,
                         width: scrollView.widthAnchor
        )
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollStack.anchor(top: scrollView.topAnchor,
                      leading: scrollView.leadingAnchor,
                      bottom: scrollView.bottomAnchor,
                      trailing: scrollView.trailingAnchor,
                      width: scrollView.widthAnchor
        )
        
        bannerBar.anchor(heightConstant: 600)
        banner2Bar.anchor(heightConstant: 600)
    }
 
}
