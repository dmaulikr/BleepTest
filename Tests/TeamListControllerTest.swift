import XCTest

@testable import BleepTest

class TeamListControllerTest: XCTestCase {
    
    var teamListContorller: TeamListController!
    
    override func setUp() {
        teamListContorller = TeamListController()
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
