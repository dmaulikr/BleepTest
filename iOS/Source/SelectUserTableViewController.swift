import UIKit

class SelectUsersTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectUserTableViewController {
    // MARK: - UITableViewDelegate

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
