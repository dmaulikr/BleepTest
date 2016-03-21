import UIKit
import CoreData
import DATAStack

class CompletedTestTableController: BaseTableViewController {
    static let CellIdentifier = "CellID"
    var items = [CompletedTest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test Times"
        self.tableView = UITableView(frame: self.tableView.frame, style: .Grouped)
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = .whiteColor()
        self.tableView.registerClass(CompletedTestTableCell.self, forCellReuseIdentifier: CompletedTestTableController.CellIdentifier)
        
        self.fetchCurrentObjects()
    }
    
    func fetchCurrentObjects() {
        items = fetcher.fetchCompletedTest{_ in}
    }
}

extension CompletedTestTableController {
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(CompletedTestTableController.CellIdentifier, forIndexPath: indexPath) as! CompletedTestTableCell
        cell.selectionStyle = .None
        let data = self.items[indexPath.section]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy, H:mm"
        dateFormatter.stringFromDate(NSDate())
        cell.dateLabel.text = dateFormatter.stringFromDate(data.createdDate)
        cell.levelLabel.text = "Level: \(String(data.level))"
        cell.lapLabel.text = "Lap: \(String(data.lap))"
        return cell
    }
}

extension CompletedTestTableController {
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
}
