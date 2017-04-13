import XCTest
@testable import BleepTest

class CreateTeamControllerTest: XCTestCase {
    
    func testController() {
        let createTeamController = CreateTeamController()
        XCTAssertNotNil(createTeamController)
    }
}
