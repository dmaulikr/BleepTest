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
        tableView.register(TeamCell.self, forCellReuseIdentifier: NSStringFromClass(TeamCell.self))
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TeamCell)
    }
    
    func testCellForRow_DequeuesCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = teamDataProvider
        mockTableView.register(TeamCell.self, forCellReuseIdentifier: NSStringFromClass(TeamCell.self))
        
        teamDataProvider.manager.add(Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCell_GetsCalledInCellForRow() {
        let mockTableView = MockTableView()
        
        mockTableView.dataSource = teamDataProvider
        mockTableView.register(MockTeamCell.self, forCellReuseIdentifier: NSStringFromClass(TeamCell.self))
        
        let team = Team(name: "Team name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        teamDataProvider.manager.add(team)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTeamCell
        XCTAssertEqual(cell.team?.name, team.name)
    }
    
}

extension TeamDataProividerTests {
    
    class MockTableView: UITableView {
        
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    

    class MockTeamCell: TeamCell {
        
        var team: Team?
    
        override func configCellWith(_ team: Team) {
            self.team = team
        }
    }
}
