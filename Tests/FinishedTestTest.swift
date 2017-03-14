import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class FinishedTestControllerTest: XCTestCase {
    
    private lazy var data: DATAStack = {
        let data = DATAStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return data
    }()
    
    private lazy var fetcher: Fetcher = {
        let fetcher = Fetcher(dataStack: self.data)
        return fetcher
    }()
    
    private lazy var writer: Writer = {
        let writer = Writer(dataStack: self.data)
        return writer
    }()
    
    func testFinishedBleepTestController() {
        let finishedBleepTestController = FinishedBleepTestController(fetcher: fetcher, writer: writer, dataStack: data)
        XCTAssertNotNil(finishedBleepTestController)
        
        //Test the rootview of FinishedBleepTestController
        if !(finishedBleepTestController.view is FinishedBleepTestView) {
            XCTFail()
        }
        
    }    
}
