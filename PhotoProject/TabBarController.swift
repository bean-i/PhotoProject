//
//  TabBarController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        configureTabBarAppearance()
    }
    
    func configureTabBarController() {
        let firstVC = TopicViewController()
        firstVC.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        let secondVC = RandomPhotoViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "film")
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = PhotoSearchViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        let fourthVC = FourthViewController()
        fourthVC.tabBarItem.image = UIImage(systemName: "heart")
        
        setViewControllers([firstNav, secondNav, thirdNav, fourthVC], animated: true)
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.clear]
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }

}
