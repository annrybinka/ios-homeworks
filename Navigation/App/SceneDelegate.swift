import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appConfiguration: AppConfiguration?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let appCoordinator = DocumentsCoordinator()
        window.rootViewController = appCoordinator.startView()
        window.makeKeyAndVisible()
        
        self.window = window
        
        guard let appConfiguration = AppConfiguration.allCases.randomElement() else {
            print("appConfiguration is nil")
            return
        }
        NetworkService.request(for: appConfiguration)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

