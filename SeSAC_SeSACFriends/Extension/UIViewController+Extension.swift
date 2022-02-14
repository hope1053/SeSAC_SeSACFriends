//
//  UIViewController+Extension.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

extension UIViewController {
    
    var topVC: UIViewController? {
        return self.topVC(currentViewController: self)
    }
    
    // currentViewController: TabBarController
    func topVC(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topVC(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController {
               return self.topVC(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topVC(currentViewController: presentedViewController)
        } else {
            return currentViewController
        }
    }
}
