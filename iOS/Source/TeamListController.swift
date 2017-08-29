import UIKit

class TeamListController: BaseTableViewController {
    
    var dataProvider: TeamDataProvider! = TeamDataProvider()

    override func viewDidLoad() {
        self.title = "Teams"
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
        self.tableView.register(TeamCell.self, forCellReuseIdentifier: TeamCell.Identifier)
        self.addNavigationItems()
    }
    
    func addNavigationItems() {
        let rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: #selector(createTeamButtonAction(_:)))
        rightBarButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 40.0)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.veryLightGrayColor()
    }
}

//MARK: Actions
extension TeamListController {
    func createTeamButtonAction(_ sender: UIButton!) {
        self.navigationController?.present(CreateTeamController(fetcher: fetcher, writer: writer, dataStack: dataStack!), animated: true, completion: nil)
    }
}
