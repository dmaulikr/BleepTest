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
        request.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]
        
        let dataSource = DATASource(tableView: self.tableView, cellIdentifier: "Cell", fetchRequest: request, mainContext: self.dataStack!.mainContext, configuration: { cell, item, indexPath in
            cell.textLabel?.text = item.valueForKey("username") as? String
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self.dataSource
        self.tableView.tableFooterView = UIView()
        addNavigationItems()
    }
    
    func addNavigationItems() {
        self.title = "Select User"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(closeButtonAction(_:)))
        let rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(createUserButtonAction(_:)))
        rightBarButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 40.0)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
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

extension SelectUserTableViewController {
    //MARK: Actions
    func closeButtonAction(sender:UIButton!) {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

    func createUserButtonAction(sender: UIButton!) {
        self.navigationController?.presentViewController(CreateSinglePlayerController(fetcher: fetcher, writer: writer, dataStack: dataStack!), animated: true, completion: nil)
    }
}
