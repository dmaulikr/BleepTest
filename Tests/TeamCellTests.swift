import XCTest
@testable import BleepTest

class TeamCellTests: XCTestCase {
   
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
