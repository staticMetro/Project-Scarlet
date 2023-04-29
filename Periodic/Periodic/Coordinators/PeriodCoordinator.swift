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
//        coordinateToHomeView()
        
//        let result = fetchData()
//        switch result {
//        case .success:
//            print("sucess")
//            DispatchQueue.main.async { [weak self] in
//                self?.coordinateToProfileView()
//        }
//        case .timedOut:
//            print("error")
//            DispatchQueue.main.async { [weak self] in
//                self?.coordinateToErrorView()
//        }
//
//        }
        dataManager.testAPICall()
        
    }
    func fetchData() -> DispatchTimeoutResult {
        let group = DispatchGroup()
        group.enter()
        dataManager.fetchUserInfo { [weak self] status in
            switch status {
            case .initial, .loading:
                self?.coordinateToLoadingView()
            case .success(let _):
                group.leave()
                print("success")
//                self?.UserModel = userModel
            case .failed:
                break
            }
        }
        return group.wait(timeout: DispatchTime.now() + 10)
    }
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
//            navigationController.removeFromParent()
            navigationController.addChild(viewController)
            navigationController.viewControllers = [navigationController.children[0]]
        }
        
        func coordinateToProfileView() {
            let viewController = ProfileViewController()
            
            navigationController.addChild(viewController)
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
    func coordinateToHomeView() {
//        let viewController = MenuTabBarController()
//        navigationController.addChild(viewController)
//        navigationController.viewControllers = [navigationController.children[0]]
        
        let viewController = MenuTabBarController()
        navigationController.viewControllers = [viewController]
    }
}
