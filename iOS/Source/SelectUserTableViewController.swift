import UIKit
import DATASource
import DATAStack
import CoreData

class SelectUserTableViewController: BaseTableViewController {

    lazy var dataSource: DATASource = {
        let request = NSFetchRequest(entityName: "Player")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        
        let dataSource = DATASource(tableView: self.tableView, cellIdentifier: "Cell", fetchRequest: request, mainContext: self.dataStack!.mainContext, configuration: { cell, item, indexPath in
            cell.textLabel?.text = item.valueForKey("username") as? String
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView = UITableView(frame: self.tableView.frame, style: .Grouped)
        self.tableView.dataSource = self.dataSource
    }
    
}
