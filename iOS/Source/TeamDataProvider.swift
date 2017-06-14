import UIKit

class TeamDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var manager = TeamManager()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(TeamCell.self), for: indexPath) as! TeamCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.count 
    }

}
