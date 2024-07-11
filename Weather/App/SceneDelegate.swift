//
//  SceneDelegate.swift
//  Weather
//
//  Created by NERO on 7/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let rootVC = UINavigationController(rootViewController: WeatherViewController())
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}
