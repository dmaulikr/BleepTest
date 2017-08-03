import UIKit
import Sync
import CoreData

class TeamDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var manager = TeamManager()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TeamCell.self), for: indexPath) as! TeamCell
        
        if let team = manager.atIndex(indexPath.row) {
            cell.configCellWith(team)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.count
    }

}
