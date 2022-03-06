//
//  ViewController.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import UIKit
import Alamofire

let BANNER_API = "https://staging.sary.co/api/v2.5.1/baskets/76097/banners/"
let CATALOG_API = "https://staging.sary.co/api/baskets/76097/catalog/"

let headers: HTTPHeaders = [
    "Device-Type": "ios",
    "App-Version": "3.1.1.0.0",
    "Accept-Language": "en",
    "Authorization": "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ODg2NiwidXNlcl9waG9uZSI6Ijk2NjU2NDk4OTI1MCJ9.VYE28vtnMRLmwBISgvvnhOmPuGueW49ogOhXm5ZqsGU"
]

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = .white
        //        AF.request(BANNER_API, headers: headers).responseDecodable(of: BannerAPIResult.self) { response in
        //            debugPrint(response)
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let storeTab = StoreTabViewController()
        let storeTabBarItem = UITabBarItem(title: "المتجر", image: UIImage(named: "store"), tag: 0)
        storeTab.tabBarItem = storeTabBarItem
        
        let ordersTab = OrdersTabViewController()
        let ordersTabBarItem = UITabBarItem(title: "الطلبات", image: UIImage(named: "orders"), tag: 1)
        ordersTab.tabBarItem = ordersTabBarItem
        
        let accountTab = AccountTabViewController()
        let accountTabBarItem = UITabBarItem(title: "صفحتي", image: UIImage(named: "account"), tag: 2)
        accountTab.tabBarItem = accountTabBarItem
        
        viewControllers = [storeTab, ordersTab, accountTab]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.3
        let animator = UIViewPropertyAnimator(duration: timeInterval, curve: .easeOut) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.25, y: 0.25)
        }
        animator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        animator.startAnimation()
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
}

class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.25
    
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let fromIndex = getIndex(forViewController: toVC),
            let toIndex = getIndex(forViewController: fromVC)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
