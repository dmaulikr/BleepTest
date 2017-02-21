import UIKit
import DATASource
import DATAStack
import CoreData

class SelectUserTableViewController: BaseTableViewController {
    
    lazy var dataSource: DATASource = {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]
        
        let dataSource = DATASource(tableView: self.tableView, cellIdentifier: "Cell", fetchRequest: request, mainContext: self.dataStack!.mainContext, configuration: { cell, item, indexPath in
            cell.textLabel?.text = item.value(forKey: "username") as? String
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        addNavigationItems()
    }
    
    func setUpTable() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self.dataSource
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.veryLightGrayColor()
    }
    
    func addNavigationItems() {
        self.title = "Select User"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeButtonAction(_:)))
        let rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: #selector(createUserButtonAction(_:)))
        rightBarButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 40.0)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

//MARK: UITableViewDelegate
extension SelectUserTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = self.dataSource.objectAtIndexPath(indexPath) as! Player
        writer.setSelectedPlayer(player)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Actions
extension SelectUserTableViewController {
    func closeButtonAction(_ sender:UIButton!) {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }

    func createUserButtonAction(_ sender: UIButton!) {
        self.navigationController?.present(CreateSinglePlayerController(fetcher: fetcher, writer: writer, dataStack: dataStack!), animated: true, completion: nil)
    }
}
