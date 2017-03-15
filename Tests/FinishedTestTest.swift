import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class FinishedTestControllerTest: XCTestCase {
    
    func testFinishedBleepTestController() {
        let result: Result = Result(level: "1", lap: "2", vo2Max: "3", distance: "4", playerName: "Bob Jones")
        let finishedBleepTestController = FinishedBleepTestController(result: result)        
    
        XCTAssertNotNil(finishedBleepTestController)
        
        //Test the rootview of FinishedBleepTestController
        if !(finishedBleepTestController.view is FinishedBleepTestView) {
            XCTFail()
        }
        
    }
}
