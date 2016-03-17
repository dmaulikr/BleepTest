
import UIKit

class MenuTableController: BaseTableViewController {
    static let CellIdentifier = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .Grouped)
        self.tableView.registerClass(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableController.CellIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension MenuTableController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MenuTableController.CellIdentifier, forIndexPath: indexPath) as! MenuTableViewCell
        cell.selectionStyle = .None
        cell.cellLabel.text = "About"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuTableController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}