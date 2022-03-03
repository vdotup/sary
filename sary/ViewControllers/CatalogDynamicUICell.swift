//
//  CatalogDynamicUICell.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import Foundation
import UIKit

class CatalogDynamicUICell: UICollectionViewCell {
    
    let catalogTitleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        addSubview(catalogTitleLabel)
        catalogTitleLabel.anchor(top: topAnchor, leading: leadingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(catalog: Catalog) {
        catalogTitleLabel.text = catalog.title
        if !catalog.show_title {
            catalogTitleLabel.removeFromSuperview()
        }
        
        // data_type can be enum!! and use switch here
        
        if catalog.data_type == "smart" {
            // horizontal stack with rounded rectangles
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 5
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.backgroundColor = .blue
            addSubview(stack)
            stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
            
            for data in catalog.data {
                let view = smartGridItem(data: data)
                stack.addArrangedSubview(view)
            }
            
        } else if catalog.data_type == "group" {
            
            let catalogGroupCollectionVC = CatalogGroupCollectionViewController()
            addSubview(catalogGroupCollectionVC.view)
            
            catalogGroupCollectionVC.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
            
        } else if catalog.data_type == "banner" {
            
        }
    }
    
    private func smartGridItem(data: CatalogData) -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 11
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .red
        
        let nameLabel = UILabel()
        nameLabel.font = nameLabel.font.withSize(10)
        nameLabel.text = data.name
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        stack.addArrangedSubview(nameLabel)
        return view
        
        // 75
        // 11
        // 19
    }
    
}
