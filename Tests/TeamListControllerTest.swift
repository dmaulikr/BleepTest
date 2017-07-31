import XCTest
import Sync
import CoreData
@testable import BleepTest

class TeamListControllerTest: XCTestCase {
    
    var teamListContorller: TeamListController!
    
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
        teamListContorller = TeamListController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        _ = teamListContorller.view
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(teamListContorller.tableView)
    }
    
    func testVeiwDidLoad_ShouldSetTableDataSource() {
        XCTAssertNotNil(teamListContorller.tableView.dataSource)
        XCTAssertTrue(teamListContorller.tableView.dataSource is TeamDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(teamListContorller.tableView.delegate)
        XCTAssertTrue(teamListContorller.tableView.delegate is TeamDataProvider)
    }
    
    func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
        XCTAssertEqual(teamListContorller.tableView.delegate as? TeamDataProvider, teamListContorller.tableView.dataSource as? TeamDataProvider)
    }
    
}
