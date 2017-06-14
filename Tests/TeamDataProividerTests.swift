import XCTest
import Sync
import CoreData
@testable import BleepTest

class TeamDataProividerTests: XCTestCase {
    
    let teamDataProvider = TeamDataProvider()
    let tableView = UITableView()
    var dataStack: DataStack = DataStack()
    var entity: NSEntityDescription?
    
    override func setUp() {
        super.setUp()
        self.dataStack = self.createDataStack()
        self.entity = NSEntityDescription.entity(forEntityName: "Team", in: dataStack.mainContext)
        tableView.dataSource = teamDataProvider
    }
    
    func createDataStack() -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return dataStack
    }
    
    func testNumberOfSections_IsOne() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberRowsInFirstSection_IsTeamCount() {
        teamDataProvider.manager.add(Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext))
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func testCellForRow_ReturnsTeamCell() {
        teamDataProvider.manager.add(Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TeamCell)
    }
    
}
