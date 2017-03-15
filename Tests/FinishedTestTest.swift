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
        
        //Test the views frame
        XCTAssertEqual(finishedBleepTestController.rootView.frame, UIScreen.main.bounds)
        
        //Test labels initialised
        XCTAssertNotNil(finishedBleepTestController.rootView.levelLabel, "levelLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapLabel, "lapLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.playerNameLabel, "playerNameLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.vo2MaxLabel, "vo2MaxLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.distanceLabel, "distanceLabel Not Initialised")

        //Test labels value
        XCTAssertEqual(finishedBleepTestController.rootView.levelLabel.text, "1")
        XCTAssertEqual(finishedBleepTestController.rootView.lapLabel.text, "2")
        XCTAssertEqual(finishedBleepTestController.rootView.vo2MaxLabel.text, "3")
        XCTAssertEqual(finishedBleepTestController.rootView.distanceLabel.text, "4")
        XCTAssertEqual(finishedBleepTestController.rootView.playerNameLabel.text, "Bob Jones")
        
        //Test labels added to the cell view
        XCTAssertNotNil(finishedBleepTestController.rootView.levelLabel.superview, "levelLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapLabel.superview, "lapLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.playerNameLabel.superview, "playerNameLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.vo2MaxLabel.superview, "vo2MaxLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.distanceLabel.superview, "distanceLabel Not Added To View")
        
    }
}
