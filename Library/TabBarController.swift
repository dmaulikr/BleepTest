//
//  TabBarController.swift
//  Project
//
//  Created by Ieuan Peace on 24/03/2016.
//
//

import UIKit

class TabBarController: UITabBarController {
    internal var fetcher: Fetcher
    
    // MARK: - Initializers
    
     init(fetcher: Fetcher) {
        self.fetcher = fetcher
        super.init(nibName: nil, bundle: nil)
        self.setUpTabBar()
    }
    
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpTabBar(){
        UITabBar.appearance().barTintColor = UIColor.whiteColor()

        let item1 = BleepTestController(fetcher: self.fetcher)
        let icon1 = UITabBarItem(title: "Bleep Test", image:nil, selectedImage:nil)
        item1.tabBarItem = icon1
        let navigationController1 = UINavigationController(rootViewController: item1)
        navigationController1.navigationBar.barTintColor = .customBlueColor()
        navigationController1.navigationBar.tintColor = .whiteColor()
        navigationController1.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        let storyboard = UIStoryboard(name: "CompletedTests", bundle: nil)
        let item2 = storyboard.instantiateViewControllerWithIdentifier("viewController")
        let navigationController2 = UINavigationController(rootViewController: item2)
        navigationController2.navigationBar.barTintColor = .customBlueColor()
        navigationController2.navigationBar.tintColor = .whiteColor()
        navigationController2.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController2.title = "My Times"
        
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
