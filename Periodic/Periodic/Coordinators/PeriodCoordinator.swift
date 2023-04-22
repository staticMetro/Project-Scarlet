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
    private let dataManager: PeriodDataManaging
    private let navigationController: UINavigationController
   
    init(navigationController: UINavigationController, dataManager: PeriodDataManaging) {
        self.navigationController = navigationController
        self.dataManager = dataManager
    }
    
    func start() {
//        coordinateToLoadingView()
//        let result = fetchData()
//        switch result {
//        case .success:
//            DispatchQueue.main.async { [weak self] in
//                coordinateToWelcomeView()
//            }
//        case .timedOut:
//            DispatchQueue.main.async { [weak self] in
//                coordinateToCalendarView()
//            }
            //        coordinateToLoadingView()
            //        coordinateToPeriodView()
            //        coordinateToCalendarView()
                    coordinateToWelcomeView()
//            coordinateToErrorView()
//            coordinateToProfileView()
        }
        
//        func fetchData() -> DispatchTimeoutResult {
//            let group = DispatchGroup()
//            
//            group.enter()
//            dataManager.fetchUserInfo() { [weak self] status in
//                switch status {
//                case .initial, .loading:
//                    coordinateToLoadingView()
//                case .success(let user):
//                    group.leave()
//                    //                    user = user
//                case .failed:
//                    break
//                }
//            }
//            
//            group.enter()
//            dataManager.fetchUserPeriodInfo() { [weak self] status in
//                switch status {
//                case .initial, .loading:
//                    self?.coordinateToLoadingView()
//                case .success(let period):
//                    group.leave()
//                    period = period
//                case .failed:
//                    break
//                }
//            }
//            return group.wait(timeout: DispatchTime.now() + 10)
//        }
        
        func coordinateToPeriodView() {
            let viewController = PeriodViewController()
            navigationController.pushViewController(viewController, animated: true)
        }
        
        func coordinateToCalendarView() {
            let viewController = CalendarViewController()
            navigationController.viewControllers = [viewController]
        }
        
        func coordinateToLoadingView() {
            let viewController = LoadingViewController()
            navigationController.viewControllers = [viewController]
        }
        
        func coordinateToWelcomeView() {
            let viewController = WelcomeScreenViewController()
            navigationController.addChild(viewController)
            navigationController.viewControllers = [navigationController.children[0]]
        }
        
        func coordinateToProfileView() {
            let viewController = ProfileViewController()
            navigationController.viewControllers = [viewController]
        }
        func coordinateToErrorView() {
            let viewController = ErrorViewController()
//            navigationController.removeViewController(inactiveViewController: viewController)
            navigationController.addChild(viewController)
//            navigationController.removeFromParent()
            var viewModel = ErrorViewModel()
            viewModel.endClosure = { [weak self] action in
                switch action {
                case .exit:
                    self?.start()
                }
            }
            viewController.viewModel = viewModel
            navigationController.viewControllers = [navigationController.children[0]]
    }
}
