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
        XCTAssertEqual(teamManager.count, 1, "teamManager should be one")
    }
    
    func testTeamAtIndex_ShouldReturnPreviouslyAddedTeam() {
        let team = Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        teamManager.add(team)
        
        let returnedTeam = teamManager.atIndex(0)
        XCTAssertEqual(team.name, returnedTeam?.name, "Both teams should be the same")
    }
    
}
