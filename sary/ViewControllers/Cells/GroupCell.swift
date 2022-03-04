//
//  GroupCell.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 04/03/2022.
//

import UIKit

class GroupCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    public func configure(catalog: Catalog) {
        let collectionContainer = UIView()
        
        let catalogGroupCollectionVC = CatalogGroupCollectionViewController()
        contentView.addSubview(collectionContainer)
        collectionContainer.addSubview(catalogGroupCollectionVC.view)
        
        collectionContainer.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
        catalogGroupCollectionVC.view.anchor(top: collectionContainer.topAnchor, leading: collectionContainer.leadingAnchor, bottom: collectionContainer.bottomAnchor, trailing: collectionContainer.trailingAnchor)
        
    }
    
}
