import XCTest

@testable import BleepTest

class TeamDataProividerTests: XCTestCase {
    
    func testNumberOfSections_IsOne() {
        let teamDataProvider = TeamDataProvider()
        
        let tableView = UITableView()
        tableView.dataSource = teamDataProvider
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
}
