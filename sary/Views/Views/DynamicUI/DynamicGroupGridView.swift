//
//  DynamicGroupGridView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class DynamicGroupGridView: UIView {
    
    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    var images: [UIImageView] = []
    var rowCount: Int!
    
    required init(catalog: CatalogViewModel) {
        super.init(frame: .zero)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Almarai-Bold", size: 16)
        addSubview(titleLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, heightConstant: 20,
                          padding: .init(top: 15, left: 25, bottom: 0, right: 0))
        
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
                              padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        self.setup(catalog: catalog)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let h = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.anchor(heightConstant: h)
    }
    
    public func setup(catalog: CatalogViewModel) {
        images.removeAll()
        rowCount = catalog.row_count
        titleLabel.text = catalog.title
        let data = catalog.data
        for datum in data {
            let imageView = UIImageView()
            //imageView.load(url: URL(string: datum.image!)!)
            imageView.load(url: URL(string: "https://devcdn.sary.co/layout_groups/2020/08/31/%D8%AD%D9%84%D9%88%D9%8A%D8%A7%D8%AA.png")!)
            images.append(imageView)
        }
    }
    
}

extension DynamicGroupGridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
