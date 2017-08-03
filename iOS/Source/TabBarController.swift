import UIKit
import Sync

class TabBarController: UITabBarController {
    internal var fetcher: Fetcher
    internal var writer: Writer
    internal var dataStack: DataStack?
    
    // MARK: - Initializers
    
    internal init(fetcher: Fetcher, writer: Writer, dataStack: DataStack) {
        self.fetcher = fetcher
        self.writer = writer
        self.dataStack = dataStack
        super.init(nibName: nil, bundle: nil)
        self.setUpTabBar()
    }
    
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpTabBar(){
        UITabBar.appearance().barTintColor = UIColor.white

        let item1 = HomeController(fetcher: self.fetcher, writer: self.writer, dataStack: self.dataStack!)
        let icon1 = UITabBarItem(title: "Bleep Test", image:UIImage(named:"BleepTest"), selectedImage:UIImage(named:"BleepTest"))
        item1.tabBarItem = icon1
        let navigationController1 = UINavigationController(rootViewController: item1)
        navigationController1.navigationBar.barTintColor = .customBlueColor()
        navigationController1.navigationBar.tintColor = .white
        navigationController1.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        let item2 = ResultsTableController(fetcher: self.fetcher, writer: self.writer, dataStack: self.dataStack!)
        let icon2 = UITabBarItem(title: "Results", image:UIImage(named:"Graph"), selectedImage:UIImage(named:"Graph"))
        item2.tabBarItem = icon2
        let navigationController2 = UINavigationController(rootViewController: item2)
        navigationController2.navigationBar.barTintColor = .customBlueColor()
        navigationController2.navigationBar.tintColor = .white
        navigationController2.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let item3 = TeamListController(fetcher: self.fetcher, writer: self.writer, dataStack: self.dataStack!)
        let icon3 = UITabBarItem(title: "Team", image:UIImage(named:"group"), selectedImage:UIImage(named:"group"))
        item3.tabBarItem = icon3
        let navigationController3 = UINavigationController(rootViewController: item3)
        navigationController3.navigationBar.barTintColor = .customBlueColor()
        navigationController3.navigationBar.tintColor = .white
        navigationController3.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let controllers = [navigationController1, navigationController2, navigationController3]
        self.viewControllers = controllers
    }
    
}
