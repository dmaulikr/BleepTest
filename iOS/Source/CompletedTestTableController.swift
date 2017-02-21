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
    
    fileprivate lazy var fetcher: Fetcher = {
        let url = URL(string: "levelsData.json")!
        let data = DATAStack(modelName: "iOS", bundle: Bundle.mainBundle, storeType:.SQLite)
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
    
    override func viewWillAppear(_ animated: Bool) {
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let data = self.items[indexPath.row]
        let player = data.player as! Player
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        dateFormatter.string(from: Date())
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clear
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
            
            if let dateLabel = cell.viewWithTag(100) as? UILabel {
                dateLabel.text = dateFormatter.string(from: data.createdDate as Date)
            }
            if let dateLabel = cell.viewWithTag(10) as? UILabel{
                dateLabel.text = dateFormatter.string(from: data.createdDate as Date)
            }
            if let levelLabel = cell.viewWithTag(101) as? UILabel{
                levelLabel.text = String(describing: data.level)
            }
            if let levelLabel = cell.viewWithTag(11) as? UILabel{
                levelLabel.text = String(describing: data.level)
            }
            if let lapLabel = cell.viewWithTag(102) as? UILabel{
                lapLabel.text = String(describing: data.lap)
            }
            if let lapLabel = cell.viewWithTag(12) as? UILabel{
                lapLabel.text = String(describing: data.lap)
            }
            if let distanceLabel = cell.viewWithTag(103) as? UILabel{
                distanceLabel.text = "\(String(describing: data.distance))m"
            }
            if let vo2MaxLabel = cell.viewWithTag(104) as? UILabel{
                vo2MaxLabel.text = String(format: "%.3f", data.vo2Max)
            }
            if let playerLabel = cell.viewWithTag(105) as? UILabel{
                playerLabel.text = String(player.username)
            }
            if let playerLabel = cell.viewWithTag(13) as? UILabel{
                playerLabel.text = String(player.username)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
}

extension CompletedTestTableController {
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
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
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
}
