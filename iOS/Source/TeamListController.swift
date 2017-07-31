import UIKit

class TeamListController: BaseTableViewController {
    
    var dataProvider: TeamDataProvider! = TeamDataProvider()

    override func viewDidLoad() {
        self.title = "Teams"
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
    }
    
}
