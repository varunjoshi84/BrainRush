//
//  MainTabBarController.swift
//  BrainRush
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        // Tab 1: Dashboard
        let dashboardVC = DashboardViewController()
        let nav1 = UINavigationController(rootViewController: dashboardVC)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        // Tab 2: Topics
        let topicsVC = TopicsViewController()
        let nav2 = UINavigationController(rootViewController: topicsVC)
        nav2.tabBarItem = UITabBarItem(title: "Topics", image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))
        
        // Tab 3: Achievements
        let achievementsVC = AchievementsViewController()
        let nav3 = UINavigationController(rootViewController: achievementsVC)
        nav3.tabBarItem = UITabBarItem(title: "Achievements", image: UIImage(systemName: "trophy"), selectedImage: UIImage(systemName: "trophy.fill"))
        
        // Tab 4: Profile
        let profileVC = ProfileViewController()
        let nav4 = UINavigationController(rootViewController: profileVC)
        nav4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    private func setupAppearance() {
        tabBar.tintColor = BrainRushTheme.primaryPurple
        tabBar.unselectedItemTintColor = BrainRushTheme.textSecondary
        tabBar.backgroundColor = .white
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
