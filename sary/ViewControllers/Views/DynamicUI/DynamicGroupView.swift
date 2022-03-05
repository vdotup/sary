//
//  DynamicGroupView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class DynamicGroupView: UIView {
    
    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    var images: [UIImageView] = []
    var rowCount: Int = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.text = "Title"
        addSubview(titleLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, heightConstant: 20)
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                              padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let h = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.anchor(heightConstant: h)
    }
    
    public func configure(catalog: Catalog) {
        images.removeAll()
        rowCount = catalog.row_count
        titleLabel.text = catalog.title
        let data = catalog.data
        for datum in data {
            let imageView = UIImageView()
            imageView.load(url: URL(string: datum.image!)!)
            images.append(imageView)
        }
    }
    
}

extension DynamicGroupView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = images[indexPath.row]
        cell.addSubview(imageView)
        imageView.fillSuperview()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let width = (collectionView.frame.width / CGFloat(rowCount)) - spacing
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
}
