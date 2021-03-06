//
//  BannerView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class BannerView: UIView {
    
    var container: UIView!
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    
    var images: [UIImageView] = []
    var timer: Timer!
    var infiniteSize: Int = 2000
    var onlyOnce: Bool = true
    
    let dummy = ["https://devcdn.sary.co/banners/2020/09/11/June_Banners-02.png",
                 "https://devcdn.sary.co/phAA.png"]
    
    required init(banners: [BannerViewModel]) {
        super.init(frame: .zero)
        
        container = UIView()
        addSubview(container)
        container.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: 25))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pageControl = UIPageControl(frame: CGRect(origin: .zero, size: .init(width: 200, height: 50)))
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.isUserInteractionEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = .clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        container.addSubview(collectionView)
        collectionView.fillSuperview()
        
        container.addSubview(pageControl)
        pageControl.anchor(bottom: container.bottomAnchor,
                           centerX: container.centerXAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        anchor(heightConstant: 160)
        
        self.setup(banners: banners)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(banners: [BannerViewModel]) {
        if dummy.count == 2 {
            for img in dummy {
                let imageView = UIImageView()
                imageView.load(url: URL(string: img)!)
                images.append(imageView)
            }
        }
        pageControl.numberOfPages = images.count
        return
        for banner in banners {
            let imageView = UIImageView()
            imageView.load(url: URL(string: banner.image)!)
            images.append(imageView)
        }
    }
    
    @objc func autoScroll() {
        guard let currentItemNumber = collectionView.indexPathsForVisibleItems.first?.item  else { return }
        let nextItemNumber = currentItemNumber + 1
        let nextIndexPath = IndexPath(item: nextItemNumber, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .right, animated: true)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        startTimer()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        infiniteSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = images[indexPath.item % images.count]
        cell.addSubview(imageView)
        imageView.fillSuperview()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if onlyOnce  {
            let middleIndex = images.count == 2 ? IndexPath(item: 0, section: 0) : IndexPath(item: Int (infiniteSize / 2), section: 0)
            collectionView.scrollToItem(at: middleIndex, at: .left, animated: false)
            startTimer()
            onlyOnce = false
        }
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
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageControl(scrollView: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl(scrollView: scrollView)
    }
    
    func updatePageControl(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.bounds.size.width)
        let currentPageNumber = Int(pageNumber) % images.count
        pageControl.currentPage = currentPageNumber
    }
    
}
