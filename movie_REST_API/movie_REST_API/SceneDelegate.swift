// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let movieVC = MovieViewController()
        let navController = UINavigationController(rootViewController: movieVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
