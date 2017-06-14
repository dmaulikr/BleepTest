import XCTest
@testable import BleepTest

class TeamManagerTests: XCTestCase {
    
    func testTeamsCount_Initially_ShouldBeZero() {
        let teamManager = TeamManager()
        XCTAssertEqual(teamManager.count, 0, "Initially teamManager should be zero")
    }
    
}
