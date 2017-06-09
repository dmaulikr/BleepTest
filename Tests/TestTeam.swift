import XCTest
@testable import BleepTest

class TestTeam: XCTestCase {
    
    func testInit_ShouldTakeName() {
        let item = Team(name: "Test name")
        XCTAssertNotNil(item, "Item should not be nil")
    }
    
}
