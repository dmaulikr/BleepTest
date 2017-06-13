import XCTest

@testable import BleepTest

class TestTeamListController: XCTestCase {
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        let teamListContorller = TeamListController()
        _ = teamListContorller.view
        XCTAssertNotNil(teamListContorller.tableView)
    }
    
    func testVeiwDidLoad_ShouldSetTableDataSource() {
        let teamListContorller = TeamListController()
        _ = teamListContorller.view
        XCTAssertNotNil(teamListContorller.tableView.dataSource)
        XCTAssertTrue(teamListContorller.tableView.dataSource is TeamDataProvider)
    }
    
}
