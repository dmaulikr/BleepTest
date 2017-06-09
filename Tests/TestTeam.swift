import XCTest
@testable import BleepTest

class TestTeam: XCTestCase {
    
    func testInit_ShouldTakeName() {
        let item = Team(name: "Test name")
        XCTAssertEqual(item.name, "Test name", "Item should not be nil")
    }
    
    func testInit_ShouldTakeNameAndDescription() {
        let item = Team(name: "Test name", teamDescription: "This is my team")
        XCTAssertEqual(item.teamDescription, "This is my team", "Item should not be nil")

    }
    
}
