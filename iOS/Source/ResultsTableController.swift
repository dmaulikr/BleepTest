import UIKit
import CoreData
import DATAStack
import DATASource

class ResultsTableController: BaseTableViewController {
    
    lazy var dataSource: DATASource = {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedTest")
        request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        
        let dataSource = DATASource(tableView: self.tableView, cellIdentifier:  ResultsCell.Identifier, fetchRequest: request, mainContext: self.dataStack!.mainContext, configuration: { cell, item, indexPath in
            let levelString = String(format: "Level: %@", (item.value(forKey: "level") as? NSNumber)!)
            let lapString = String(format: "Lap: %@", (item.value(forKey: "lap") as? NSNumber)!)
            let vo2MaxString = String(format: "VO2 Max: %.2f", (item.value(forKey: "vo2Max") as? Double)!)
            let distanceString = String(format: "Distance: %@", (item.value(forKey: "distance") as? NSNumber)!)
            let player = item.value(forKey: "player") as? Player
            var playerName: String = ""
            if(player != nil) {
                playerName = (player?.username)!
            }
            
            let cell = cell as! ResultsCell
            cell.setUpCell(resutsCellContent: Result(level: levelString, lap: lapString, vo2Max: vo2MaxString, distance: distanceString, playerName: playerName))
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        setUpTable()
    }
    
    func setUpTable() {
        self.tableView.register(ResultsCell.self, forCellReuseIdentifier: ResultsCell.Identifier)
        self.tableView.dataSource = self.dataSource
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.veryLightGrayColor()
    }
}

extension ResultsTableController {
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
}
