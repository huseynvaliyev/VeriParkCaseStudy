//
//  SceneDelegate.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 24.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MainVC()
        window?.makeKeyAndVisible()
        makeHandshake()
    }
    
    func makeHandshake() {
        let id = UIDevice.current.identifierForVendor?.uuidString
        let modelName = UIDevice.modelName
        let systemVersion = UIDevice.current.systemVersion
        guard let deviceId = id else { return }
        NetworkService.shared.startWithHandshake(id: deviceId, systemVersion: systemVersion, modelName: modelName) { result in
            switch result {
            case .success(let data):
                print("Data: \(data)")
                self.defaults.set(data.authorization, forKey: "Authorization")
                self.defaults.set(data.aesIV, forKey: "AESIV")
                self.defaults.set(data.aesKey, forKey: "AESKey")
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
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

