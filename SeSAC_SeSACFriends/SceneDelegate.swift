//
//  SceneDelegate.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.windowScene = windowScene
        // idToken && FCMToken 둘 다 존재 -> 인증 & 회원가입 모두 완료 : 홈 화면으로
        // idToken은 있는데 FCMToken은 없는 경우 -> 인증은 완료했는데 회원가입은 하지 않은 상태이기 때문에 회원가입(닉네임 입력화면으로)
        // 둘 다 없으면 아무것도 안했기 때문에 온보딩 화면으로
        
        let isFirstLaunch = UserDefaults.standard.string(forKey: "isFirstLaunch")
        let idToken = UserDefaults.standard.string(forKey: "idToken")
        let FCMToken = UserDefaults.standard.string(forKey: "FCMToken")
        
        print(isFirstLaunch)
        if isFirstLaunch != "no" {
            window?.rootViewController = OnBoardingViewController()
        } else {
            if idToken != nil && FCMToken != nil {
                window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
            } else if idToken != nil && FCMToken == nil {
                window?.rootViewController = UINavigationController(rootViewController: UserNameViewController())
            } else {
                window?.rootViewController = UINavigationController(rootViewController: PhoneNumInputViewController())
            }
        }

        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

