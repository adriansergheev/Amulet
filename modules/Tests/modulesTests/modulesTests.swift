import XCTest
@testable import modules

final class modulesTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(modules().text, "Hello, World!")
    }
}
