import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }

		window = UIWindow(windowScene: windowScene)

		// MARK: Build MainScreen and embed in NavigationVC as RootViewController

		let rootVC = MainScreenRouter.createModule()
		let naviVC = UINavigationController(rootViewController: rootVC)
		naviVC.setNavigationBarHidden(true, animated: false)

		window?.rootViewController = naviVC

		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {

	}

	func sceneDidBecomeActive(_ scene: UIScene) {

	}

	func sceneWillResignActive(_ scene: UIScene) {

	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		ToDoDataManager.shared.saveContext()
	}

	func sceneDidEnterBackground(_ scene: UIScene) {

	}

}

