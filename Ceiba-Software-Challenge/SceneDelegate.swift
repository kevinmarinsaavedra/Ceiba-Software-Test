//
//  SceneDelegate.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 16/9/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let appCoordinator = AppCoordinator()
        let navigationController = appCoordinator.start()
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.backgroundColor = UIColor(hexString: "#3FCB5E")
        
        let compactAppearance = standardAppearance.copy()
        
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.standardAppearance = standardAppearance
        navigationController.navigationBar.scrollEdgeAppearance = standardAppearance
        navigationController.navigationBar.compactAppearance = compactAppearance
        
        window?.rootViewController = navigationController
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

