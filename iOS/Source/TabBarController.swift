//
//  TabBarController.swift
//  Project
//
//  Created by Ieuan Peace on 24/03/2016.
//
//

import UIKit
import DATAStack

class TabBarController: UITabBarController {
    internal var fetcher: Fetcher
    internal var writer: Writer
    internal var dataStack: DATAStack?
    
    // MARK: - Initializers
    
    internal init(fetcher: Fetcher, writer: Writer, dataStack: DATAStack) {
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
        UITabBar.appearance().barTintColor = UIColor.whiteColor()

        let item1 = HomeController(fetcher: self.fetcher, writer: self.writer, dataStack: self.dataStack!)
        let icon1 = UITabBarItem(title: "Bleep Test", image:UIImage(named:"BleepTest"), selectedImage:UIImage(named:"BleepTest"))
        item1.tabBarItem = icon1
        let navigationController1 = UINavigationController(rootViewController: item1)
        navigationController1.navigationBar.barTintColor = .customBlueColor()
        navigationController1.navigationBar.tintColor = .whiteColor()
        navigationController1.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        let storyboard = UIStoryboard(name: "CompletedTests", bundle: nil)
        let item2 = storyboard.instantiateViewControllerWithIdentifier("viewController")
        item2.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named: "MyTimesIcon"), selectedImage: UIImage(named: "MyTimesIcon"))
        let navigationController2 = UINavigationController(rootViewController: item2)
        navigationController2.navigationBar.barTintColor = .customBlueColor()
        navigationController2.navigationBar.tintColor = .whiteColor()
        navigationController2.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let controllers = [navigationController1, navigationController2]
        self.viewControllers = controllers
    }
    
}

extension TabBarController{
    //MARK: UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }
}
