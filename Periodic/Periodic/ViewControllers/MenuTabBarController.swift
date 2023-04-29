//
//  MenuTabBarController.swift
//  Periodic
//
//  Created by Aimeric on 4/28/23.
//

import Foundation
import UIKit

class MenuTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = CalendarViewController()
        let image = UIImage(systemName: "calendar")
        firstViewController.tabBarItem = UITabBarItem(title: "Calendar",
                                                      image: UIImage(systemName: "calendar"), tag: 0)
        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "My Profile",
                                                       image: UIImage(systemName: "gearshape.fill"), tag: 1)
        let secondViewController = CalendarViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Tips",
                                                       image: UIImage(systemName: "heart.fill"), tag: 2)
        viewControllers = [firstViewController, secondViewController, thirdViewController]
        tabBar.tintColor = .systemPink
    }
}
