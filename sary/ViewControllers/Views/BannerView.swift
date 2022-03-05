//
//  BannerView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class BannerView: UIView {
    
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    
    var images: [UIImageView] = []
    var timer: Timer!
    var counter = 0
    var configured: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = .clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        collectionView.fillSuperview()
        
        addSubview(pageControl)
        pageControl.anchor(bottom: bottomAnchor,
                           centerX: centerXAnchor,
                           widthConstant: 100,
                           heightConstant: 40,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        anchor(heightConstant: 160)
        
        timer = Timer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(banners: [Banner]) {
        if configured { return }
        pageControl.numberOfPages = banners.count
        
        for banner in banners {
            let imageView = UIImageView()
            imageView.load(url: URL(string: banner.image)!)
            images.append(imageView)
        }
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
        }
        configured = true
    }
    
    @objc func autoScroll() {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage += 1
        }
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pageControl.currentPage = Int(ceil(x/w))
        counter = pageControl.currentPage
    }
    
    
}
