
import UIKit

class MenuTableController: BaseTableViewController {
    static let CellIdentifier = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        setUpTableView()
    }
    
    private func setUpTableView(){
        self.tableView = UITableView(frame: self.tableView.frame, style: .Grouped)
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = .whiteColor()
        self.tableView.registerClass(MenuTableCell.self, forCellReuseIdentifier: MenuTableController.CellIdentifier)
    }
}

extension MenuTableController {
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(MenuTableController.CellIdentifier, forIndexPath: indexPath) as! MenuTableCell
        cell.selectionStyle = .None
        switch (indexPath.section){
            case 0: cell.cellLabel.text = "My test times"
            case 1: cell.cellLabel.text = "Instructions"
            case 2: cell.cellLabel.text = "Rate the application"
            default: fatalError("Unknown number of sections")
        }
        return cell
    }
}

extension MenuTableController {
    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch (indexPath.section){
            case 0: self.navigationController!.pushViewController(CompletedTestTableController(fetcher: self.fetcher), animated: true)
            case 1: print("Push to the instrucions view")
            case 2: print("Rate application")
            default: fatalError("Unknown number of sections")
        }
    }
}