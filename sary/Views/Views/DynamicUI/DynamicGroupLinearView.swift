//
//  DynamicGroupLinearView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 08/03/2022.
//

import UIKit

class DynamicGroupLinearView: UIView {
    
    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    var images: [UIImageView] = []
    var rowCount = 3.75
    
    required init(catalog: CatalogViewModel) {
        super.init(frame: .zero)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Almarai-Bold", size: 16)
        addSubview(titleLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, heightConstant: 20,
                          padding: .init(top: 20, left: 25, bottom: 0, right: 0))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                              padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        
        anchor(heightConstant: 200)
        
        self.setup(catalog: catalog)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(catalog: CatalogViewModel) {
        images.removeAll()
        titleLabel.text = catalog.title
        let data = catalog.data
        for datum in data {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.load(url: URL(string: datum.image!)!)
            images.append(imageView)
        }
    }
    
}

extension DynamicGroupLinearView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = images[indexPath.row]
        cell.addSubview(imageView)
        imageView.fillSuperview()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let width = (collectionView.frame.width / CGFloat(rowCount)) - spacing
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
}
