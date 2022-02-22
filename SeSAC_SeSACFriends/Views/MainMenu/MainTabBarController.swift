//
//  MainTabBarController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/26.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setViewControlleres()
    }
    
    func setupStyle() {
        tabBar.tintColor = .brandGreen
        
        let appearance = UITabBarAppearance()
        // set tabbar opacity
        appearance.configureWithOpaqueBackground()

        // remove tabbar border line
        appearance.shadowColor = UIColor.clear

        // set tabbar background color
        appearance.backgroundColor = .white

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
                // set tabbar opacity
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        // set tabbar shadow
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
    }
    
    func setViewControlleres() {
        let firstVC = HomeViewController()
        let secondVC = ShopViewController()
        let thirdVC = FriendViewController()
        let fourthVC = MyPageViewController()
        
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home.selected"))
        secondVC.tabBarItem = UITabBarItem(title: "새싹샵", image: UIImage(named: "shop"), selectedImage: UIImage(named: "shop.selected"))
        thirdVC.tabBarItem = UITabBarItem(title: "새싹친구", image: UIImage(named: "friends"), selectedImage: UIImage(named: "friends.selected"))
        fourthVC.tabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "my"), selectedImage: UIImage(named: "my.selected"))
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        let fourthNav = UINavigationController(rootViewController: fourthVC)
        
        setViewControllers([firstNav, secondNav, fourthNav], animated: true)
    }
}
