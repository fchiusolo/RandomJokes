import XCTest
@testable import RandomJokes

class StringRangeOperationsTests: XCTestCase {}

extension StringRangeOperationsTests {
    func testShouldGetProperRange() {
        let text = "Hello, World!"
        
        let result = text.range(of: "Hello")
        
        XCTAssertEqual(result.location, 0)
        XCTAssertEqual(result.length, 5)
    }
}

extension StringRangeOperationsTests {
    func testShouldGetAllButMiddleSubstring() {
        let substring = "quo"
        let text = "qui, quo e qua"
        
        let result = text - NSString(string: text).range(of: substring)
        
        XCTAssertEqual(result, "qui,  e qua")
    }
    
    func testShouldGetAllButStartingSubstring() {
        let substring = "qui"
        let text = "qui, quo e qua"
        
        let result = text - NSString(string: text).range(of: substring)
        
        XCTAssertEqual(result, ", quo e qua")
    }
    
    func testShouldGetAllButEndingSubstring() {
        let substring = "qua"
        let text = "qui, quo e qua"
        
        let result = text - NSString(string: text).range(of: substring)
        
        XCTAssertEqual(result, "qui, quo e ")
    }
}

extension StringRangeOperationsTests {
    func testShouldGetTwoRanges() {
        let text = "Qui, quo, qua e di nuovo Qui"
        
        let result = text.ranges(of: "Qui")
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].location, 0)
        XCTAssertEqual(result[0].length, 3)
        XCTAssertEqual(result[1].location, 25)
        XCTAssertEqual(result[1].length, 3)
    }
    
    func testShouldGetThreeRanges() {
        let text = "Qui, quo, qua e di nuovo Qui e Qui"
        
        let result = text.ranges(of: "Qui")
        
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].location, 0)
        XCTAssertEqual(result[0].length, 3)
        XCTAssertEqual(result[1].location, 25)
        XCTAssertEqual(result[1].length, 3)
        XCTAssertEqual(result[2].location, 31)
        XCTAssertEqual(result[2].length, 3)
    }
}
