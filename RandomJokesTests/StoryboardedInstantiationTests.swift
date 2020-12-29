@testable import RandomJokes
import UIKit
import XCTest

class StoryboardedInstantiationTests: XCTestCase {
    func testJokeViewControllerInstantiation() {
        _ = JokeViewController.instantiate()
    }
}
