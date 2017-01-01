import UIKit
import CoreData
import DATAStack

class CompletedTestTableController: UITableViewController {
    
    static let CellIdentifier = "CellID"
    var items = [CompletedTest]()
    let kCloseCellHeight: CGFloat = 100
    let kOpenCellHeight: CGFloat = 218
    let kRowsCount = 10
    var cellHeights = [CGFloat]()
    
    private lazy var fetcher: Fetcher = {
        let url = NSURL(string: "levelsData.json")!
        let data = DATAStack(modelName: "iOS", bundle: NSBundle.mainBundle(), storeType:.SQLite)
        let fetcher = Fetcher(dataStack: data)
        return fetcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentObjects()
        createCellHeightsArray()
        self.title = "Stats"
        self.tableView.backgroundColor = .customBlueColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchCurrentObjects()
        createCellHeightsArray()
        tableView.reloadData()
    }
    
    //MARK: Fetch completed test items
    func fetchCurrentObjects() {
        items = fetcher.fetchCompletedTest{_ in}
    }
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
}

extension CompletedTestTableController {
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let data = self.items[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        dateFormatter.stringFromDate(NSDate())
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
            
            if let dateLabel = cell.viewWithTag(100) as? UILabel {
                dateLabel.text = dateFormatter.stringFromDate(data.createdDate)
            }
            if let dateLabel = cell.viewWithTag(10) as? UILabel{
                dateLabel.text = dateFormatter.stringFromDate(data.createdDate)
            }
            if let levelLabel = cell.viewWithTag(101) as? UILabel{
                levelLabel.text = String(data.level)
            }
            if let levelLabel = cell.viewWithTag(11) as? UILabel{
                levelLabel.text = String(data.level)
            }
            if let lapLabel = cell.viewWithTag(102) as? UILabel{
                lapLabel.text = String(data.lap)
            }
            if let lapLabel = cell.viewWithTag(12) as? UILabel{
                lapLabel.text = String(data.lap)
            }
            if let distanceLabel = cell.viewWithTag(103) as? UILabel{
                distanceLabel.text = "\(String(data.distance))m"
            }
            if let vo2MaxLabel = cell.viewWithTag(104) as? UILabel{
                vo2MaxLabel.text = String(format: "%.3f", data.vo2Max)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
}

extension CompletedTestTableController {
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
}
