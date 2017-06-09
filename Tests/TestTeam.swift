import XCTest
@testable import BleepTest

class TestTeam: XCTestCase {
    
    func testInit_ShouldTakeName() {
        let item = Team(name: "Test name")
        XCTAssertEqual(item.name, "Test name", "Name item should not be nil")
    }
    
    func testInit_ShouldTakeNameAndDescription() {
        let item = Team(name: "Test name", teamDescription: "This is my team")
        XCTAssertEqual(item.teamDescription, "This is my team", "Team description should not be not nil")
    }
    
}
