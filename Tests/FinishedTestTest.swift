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
        
        //Test the background colour
        XCTAssertEqual(finishedBleepTestController.rootView.backgroundColor, UIColor.white)
        
        //Test elements initialised
        XCTAssertNotNil(finishedBleepTestController.rootView.levelLabel, "levelLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.levelTitleLable, "levelTitleLable Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapLabel, "lapLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapTitleLable, "lapTitleLable Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.topLabel, "playerNameLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.bottomLabel, "vo2MaxLabel Not Initialised")
        XCTAssertNotNil(finishedBleepTestController.rootView.closeButton, "closeButton Not Initialised")

        //Test elements value
        XCTAssertEqual(finishedBleepTestController.rootView.levelLabel.text, "1")
        XCTAssertEqual(finishedBleepTestController.rootView.levelTitleLable.text, "Level")
        XCTAssertEqual(finishedBleepTestController.rootView.lapLabel.text, "2")
        XCTAssertEqual(finishedBleepTestController.rootView.lapTitleLable.text, "Lap")
        XCTAssertEqual(finishedBleepTestController.rootView.topLabel.text, "Nice one Bob Jones you have finished a Bleep Test. This is your results!")
        XCTAssertEqual(finishedBleepTestController.rootView.bottomLabel.text, "You ran a total distance of 4m and reached a maximal oxygen uptake of 3")
        XCTAssertNotNil(finishedBleepTestController.rootView.closeButton.titleLabel?.text, "Close")
        
        
        //Test elements added to the cell view
        XCTAssertNotNil(finishedBleepTestController.rootView.levelLabel.superview, "levelLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.levelTitleLable.superview, "levelTitleLable Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapLabel.superview, "lapLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.lapTitleLable.superview, "lapTitleLable Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.topLabel.superview, "playerNameLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.bottomLabel.superview, "distanceLabel Not Added To View")
        XCTAssertNotNil(finishedBleepTestController.rootView.closeButton.superview, "closeButton Not Added To View")
    }
}
