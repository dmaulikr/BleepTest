import UIKit
import DATASource
import DATAStack
import CoreData

protocol SelectUserDelegate {
    func userSelected(sender:SelectUserTableViewController, user: Player)
}

class SelectUserTableViewController: BaseTableViewController {
    
    var delegate: SelectUserDelegate?

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
        self.tableView.dataSource = self.dataSource
    }
}

extension SelectUserTableViewController {
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = self.dataSource.objectAtIndexPath(indexPath) as! Player
        delegate?.userSelected(self, user: user)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
