//
//  SceneDelegate.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        let nav = UINavigationController(rootViewController: HomeController(collectionViewLayout: collectionViewLayout))
        nav.navigationBar.prefersLargeTitles = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }

}

