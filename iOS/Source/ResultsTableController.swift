import UIKit
import CoreData
import DATAStack
import DATASource

class ResultsTableController: BaseTableViewController {
    
    lazy var dataSource: DATASource = {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedTest")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        
        let dataSource = DATASource(tableView: self.tableView, cellIdentifier: "Cell", fetchRequest: request, mainContext: self.dataStack!.mainContext, configuration: { cell, item, indexPath in
            let levelString =  String(format: "Level: %@ - Lap: %@", (item.value(forKey: "level") as? NSNumber)!, (item.value(forKey: "lap") as? NSNumber)!)
            cell.textLabel?.text = levelString
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self.dataSource
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.veryLightGrayColor()
    }
}

extension ResultsTableController {
    // MARK: - UITableViewDelegate
    
}
