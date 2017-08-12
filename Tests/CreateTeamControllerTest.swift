import XCTest
import Sync
import CoreData
@testable import BleepTest

class CreateTeamControllerTest: XCTestCase {
    
    var createTeamController: CreateTeamController!
    
    private lazy var data: DataStack = {
        let data = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
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
    
    override func setUp() {
        createTeamController = CreateTeamController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        _ = createTeamController.view
    }
    
    func testController() {
        XCTAssertNotNil(createTeamController)
    }
    
    func test_HasView() {
        XCTAssertTrue(createTeamController.view is CreateTeamView)
    }
}
