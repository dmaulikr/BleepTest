
import UIKit

class MenuTableController: BaseTableViewController {
    static let CellIdentifier = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .Grouped)
        self.tableView.registerClass(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableController.CellIdentifier)
    }
    
}

// MARK: - UITableViewDataSource

extension MenuTableController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MenuTableController.CellIdentifier, forIndexPath: indexPath) as! MenuTableViewCell
        cell.selectionStyle = .None
        switch (indexPath.section){
            case 0: cell.cellLabel.text = "My stats log"
            case 1: cell.cellLabel.text = "Instructions"
            case 2: cell.cellLabel.text = "Rate the application"
            default:fatalError("Unknown number of sections")
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuTableController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
}