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
        
        let firstVC = HomeViewController()
        let secondVC = ShopViewController()
        let thirdVC = FriendViewController()
        let fourthVC = MyPageViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "person")
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        thirdVC.title = "세번째 화면"
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        let fourthNav = UINavigationController(rootViewController: fourthVC)
        
        firstVC.tabBarItem.title = "설정 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        secondVC.tabBarItem = UITabBarItem(title: "두번째 화면", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        
        
        setViewControllers([firstNav, secondNav, thirdNav, fourthNav], animated: true)
//
//        let appearance = UITabBarAppearance()
//        appearance.configureWithDefaultBackground()
//        appearance.configureWithOpaqueBackground()
//        appearance.configureWithTransparentBackground()
//
//        tabBar.standardAppearance = appearance
//        tabBar.scrollEdgeAppearance = appearance
//        tabBar.tintColor = .black
    }
}
