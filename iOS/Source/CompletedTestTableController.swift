import UIKit
import CoreData
import DATAStack

class CompletedTestTableController: UITableViewController {
    static let CellIdentifier = "CellID"
    var items = [CompletedTest]()
    let kCloseCellHeight: CGFloat = 61
    let kOpenCellHeight: CGFloat = 183
    let kRowsCount = 10
    var cellHeights = [CGFloat]()
    private lazy var fetcher: Fetcher = {
        let url = NSURL(string: "levelsData.json")!
        let fetcher = Fetcher(baseURL: "https://server.com", modelName: "iOS", localFilePath: url)
        return fetcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test Times"
        fetchCurrentObjects()
        createCellHeightsArray()
        self.tableView.backgroundColor = .customLightBlueColor()
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
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
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
