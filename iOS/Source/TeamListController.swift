import UIKit

class TeamListController: BaseTableViewController {
    
    var dataProvider: TeamDataProvider! = TeamDataProvider()

    override func viewDidLoad() {
        self.title = "Teams"
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.veryLightGrayColor()
    }
    
}
