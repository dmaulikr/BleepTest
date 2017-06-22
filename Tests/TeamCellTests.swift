import XCTest
import Sync
import CoreData
@testable import BleepTest

class TeamCellTests: XCTestCase {
    
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
   
    func testTeamCell_HasNameLabel() {
        let controller = TeamListController()
        _ = controller.view
        
        let tableView = controller.tableView
        let dataProvider = FakeDataSource()
        tableView?.register(TeamCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TeamCell.self))
        tableView?.dataSource = dataProvider
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: NSStringFromClass(TeamCell.self), for: IndexPath(row: 0, section: 0)) as! TeamCell
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testConfigWithItem_SetsLabelTitle() {
        let controller = TeamListController()
        _ = controller.view
        
        let tableView = controller.tableView
        let dataProvider = FakeDataSource()
        tableView?.register(TeamCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TeamCell.self))
        tableView?.dataSource = dataProvider
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: NSStringFromClass(TeamCell.self), for: IndexPath(row: 0, section: 0)) as! TeamCell
        cell.configCellWith(Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext))
        
        XCTAssertEqual(cell.titleLabel.text, "Test name")
    }
}

extension TeamCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
