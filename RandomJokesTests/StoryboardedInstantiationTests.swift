import XCTest
import UIKit
@testable import RandomJokes

class StoryboardedInstantiationTests: XCTestCase {
    func testJokeViewControllerExist() {
        _ = JokeViewController.instantiate()
    }
}
