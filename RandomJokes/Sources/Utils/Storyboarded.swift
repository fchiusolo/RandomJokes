import UIKit

protocol Storyboarded {
    associatedtype ViewController

    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
    static func instantiate() -> ViewController
}

extension Storyboarded where Self: UIViewController {
    /// The default storyboard is Main.storyboard in the main bundle
    static var storyboard: UIStoryboard {
        UIStoryboard(name: "Main", bundle: .main)
    }

    /// The default identifier used for loading a view controller from the storyboard is its class name
    static var identifier: String {
        String(describing: self)
    }

    static func instantiate() -> Self {
        storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
