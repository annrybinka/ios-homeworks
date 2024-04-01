import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appConfiguration: AppConfiguration?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator()
        
        //MARK: start AppDocumentation
        appCoordinator.window = window
        appCoordinator.startAuthScreen()
        
        //MARK: start AppVK
//        window.rootViewController = appCoordinator.startView()
        
        //MARK: start NetworkService
//        guard let appConfiguration = AppConfiguration.allCases.randomElement() else {
//            print("appConfiguration is nil")
//            return
//        }
//        NetworkService.request(for: appConfiguration)
        
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
