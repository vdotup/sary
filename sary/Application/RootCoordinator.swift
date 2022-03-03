//
//  RootCoordinator.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import UIKit

//final class RootCoordinator: Coordinate {
//
//    weak var viewController: UIViewController?
//    weak var window: UIWindow? {
//        didSet {
//            viewController = window?.rootViewController
//        }
//    }
//
//    func showScreen(_ screen: Screen) {
//        switch screen {
//        case .tabBar:
//            // Init
//            let tabbar = TabBarController()
//            let viewModel = TabBarViewModel()
//            let coordinator = TabBarCoordinator()
//
//            // Reference
//            tabbar.viewModel = viewModel
//            coordinator.viewController = tabbar
//            viewModel.coordinator = coordinator
//            window?.rootViewController = tabbar
//
//            // Config
//            coordinator.setupTabbar()
//        }
//    }
//}

// MARK: - Define Screens
//extension RootCoordinator {
//    enum Screen {
//        case tabBar
//    }
//}
