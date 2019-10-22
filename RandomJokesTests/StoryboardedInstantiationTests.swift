import XCTest
import UIKit
@testable import RandomJokes

class StoryboardedInstantiationTests: XCTestCase {
    func testJokeViewControllerInstantiation() {
        _ = JokeViewController.instantiate()
    }
}
