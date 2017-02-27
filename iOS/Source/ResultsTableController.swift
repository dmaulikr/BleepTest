import UIKit
import CoreData
import DATAStack
import DATASource

class ResultsTableController: BaseTableViewController {
    
    lazy var dataSource: DATASource = {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedTest")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        
        let dataSource = DATASource(tableView: self.tableView, cellIdentifier:  ResultsCell.Identifier, fetchRequest: request, mainContext: self.dataStack!.mainContext, configuration: { cell, item, indexPath in
            let levelString =  String(format: "Level: %@", (item.value(forKey: "level") as? NSNumber)!)
            let lapString = String(format: "Lap: %@", (item.value(forKey: "lap") as? NSNumber)!)
            let vo2MaxString = String(format: "VO2 Max: %@", (item.value(forKey: "vo2Max") as? NSNumber)!)
            let distanceString = String(format: "Distance: %@", (item.value(forKey: "distance") as? NSNumber)!)
            let player = item.value(forKey: "player") as? Player
            let playerNameString = player?.username

            let cell = cell as! ResultsCell
            cell.levelLabel.text = levelString
            cell.lapLabel.text = lapString
            cell.playerNameLabel.text = playerNameString
            cell.vo2MaxLabel.text = vo2MaxString
            cell.distanceLabel.text = distanceString
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}
