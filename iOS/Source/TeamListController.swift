import UIKit

class TeamListController: UITableViewController {
    
    var dataProvider: TeamDataProvider! = TeamDataProvider()

    override func viewDidLoad() {
        self.tableView.dataSource = dataProvider
    }
    
}
