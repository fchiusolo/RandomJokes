@testable import RandomJokes
import XCTest

class HTMLDecodingTests: XCTestCase {
    func testShouldRemoveQuotesEntities() {
        let sut = "Hanna Haro doesn't say &quot;who's your daddy&quot;, because he knows the answer"

        let result = String(htmlEncodedString: sut) ?? ""

        XCTAssertEqual(result, "Hanna Haro doesn't say \"who's your daddy\", because he knows the answer")
    }
}
