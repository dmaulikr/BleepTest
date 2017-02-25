
import UIKit

class MenuTableController: BaseTableViewController {
    static let CellIdentifier = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        setUpTableView()
    }
    
    fileprivate func setUpTableView(){
        self.tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = .white
        self.tableView.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableController.CellIdentifier)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}

extension MenuTableController {
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: MenuTableController.CellIdentifier, for: indexPath) as! MenuTableCell
        cell.selectionStyle = .none
        switch (indexPath.section){
            case 0: cell.cellLabel.text = "My test times"
            case 1: cell.cellLabel.text = "Instructions"
            case 2: cell.cellLabel.text = "Rate the application"
            default: fatalError("Unknown number of sections")
        }
        return cell
    }
}

extension MenuTableController {
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        switch (indexPath.section){
            case 0:
                let storyboard = UIStoryboard(name: "CompletedTests", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "viewController")
                self.navigationController!.pushViewController(vc, animated: true)
            case 1:
                print("Push to the instrucions view")
            case 2:
                print("Rate application")
            default: fatalError("Unknown number of sections")
        }
    }
}
