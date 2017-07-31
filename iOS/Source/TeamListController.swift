import UIKit

class TeamListController: BaseTableViewController {
    
    var dataProvider: TeamDataProvider! = TeamDataProvider()

    override func viewDidLoad() {
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
    }
    
}
