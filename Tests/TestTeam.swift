import XCTest
@testable import BleepTest

class TestTeam: XCTestCase {
    
    func testInit_ShouldTakeName() {
        let item = Team(name: "Test name", teamDescription: nil)
        XCTAssertNotNil(item, "Item should not be nil")
    }
    
    func testInit_ShouldTakeNameAndDescription() {
        _ = Team(name: "Test name", teamDescription: "This is my team")
    }
    
}
