//
//  NavigationCoordinator.swift
//  BrainRush
//

import UIKit

final class NavigationCoordinator {
    
    static func showAuth(from viewController: UIViewController) {
        let authVC = AuthViewController()
        let nav = UINavigationController(rootViewController: authVC)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        nav.setNavigationBarHidden(true, animated: false)
        
        if let window = viewController.view.window {
            window.rootViewController = nav
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewController.present(nav, animated: true)
        }
    }
    
    static func showMainApp(from viewController: UIViewController) {
        let tabBar = MainTabBarController()
        
        if let window = viewController.view.window {
            window.rootViewController = tabBar
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        } else {
            tabBar.modalPresentationStyle = .fullScreen
            tabBar.modalTransitionStyle = .crossDissolve
            viewController.present(tabBar, animated: true)
        }
    }
}
