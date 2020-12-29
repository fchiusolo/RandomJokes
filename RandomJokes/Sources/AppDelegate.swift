import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        registerProviderFactories()

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let jokeComponent = JokeComponent()
        let navigationController = UINavigationController()

        window.rootViewController = navigationController
        navigationController.pushViewController(jokeComponent.jokeViewController, animated: false)

        window.makeKeyAndVisible()
        return true
    }
}
