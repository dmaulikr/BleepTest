import XCTest
import Sync
import CoreData
@testable import BleepTest

class TeamManagerTests: XCTestCase {
    
    let teamManager = TeamManager()
    var dataStack: DataStack = DataStack()
    var entity: NSEntityDescription?
    
    override func setUp() {
        super.setUp()
        self.dataStack = self.createDataStack()
        self.entity = NSEntityDescription.entity(forEntityName: "Team", in: dataStack.mainContext)
    }
    
    func createDataStack() -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return dataStack
    }
    
    func testTeamsCount_Initially_ShouldBeZero() {
        XCTAssertEqual(teamManager.count, 0, "Initially teamManager should be zero")
    }
    
    func testTeamsCount_AfterAddingOneItem_IsOne() {
        teamManager.add(Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext))
        XCTAssertEqual(teamManager.count, 1, "Initially teamManager should be one")
    }
    
}
