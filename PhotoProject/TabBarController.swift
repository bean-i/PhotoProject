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
        
        let secondVC = SecondViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "film")
        
        let thirdVC = PhotoSearchViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        let fourthVC = FourthViewController()
        fourthVC.tabBarItem.image = UIImage(systemName: "heart")
        
        setViewControllers([firstNav, secondVC, thirdNav, fourthVC], animated: true)
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }

}
