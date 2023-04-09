//
//  Coordinator.swift
//  Periodic
//
//  Created by Aimeric on 4/9/23.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class PeriodCoordinator: Coordinator {
    
    private var periodViewController: PeriodViewController
    private var calendarViewController: CalendarViewController
    private let navigationController: UINavigationController

    
    init(navigationController: UINavigationController, periodViewController: PeriodViewController, calendarViewController: CalendarViewController) {
        self.navigationController = navigationController
        self.periodViewController = periodViewController
        self.calendarViewController = calendarViewController

    }
    
    func start() {
        coordinateToPeriodView()
//        coordinateToCalendarView()
    }
    
    func coordinateToPeriodView() {
        let viewController = PeriodViewController()
        navigationController.viewControllers = [viewController]
    }
    
    func coordinateToCalendarView() {
        let viewController = CalendarViewController()
        navigationController.viewControllers = [viewController]
    }
}
