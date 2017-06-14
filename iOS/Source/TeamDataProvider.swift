import UIKit

class TeamDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var manager = TeamManager()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TeamCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.count 
    }

}
