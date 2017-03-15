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
        
        //Test labels initialised
        XCTAssertNotNil(finishedBleepTestController.rootView.levelLabel, "levelLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapLabel, "lapLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.playerNameLabel, "playerNameLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.vo2MaxLabel, "vo2MaxLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.distanceLabel, "distanceLabel Not Initialised")

        
    }
}
