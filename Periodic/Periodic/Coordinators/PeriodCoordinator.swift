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
    private let dataManager: PeriodDataManager
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dataManager: PeriodDataManager) {
        self.navigationController = navigationController
        self.dataManager = dataManager
    }
    func start() {
        coordinateToLoginView()
//        let username = "tshibuaya.aimeric@gmail.com"
//        let password = "12345678"
//        login(username: username, password: password)
    }
    func login(username: String, password: String) {
        dataManager.login(username: username, password: password) { [self] success, message in
            if success {
                DispatchQueue.main.async {
                    // Navigate to the home screen
                    self.coordinateToHomeView()
    //                viewController.viewModel = viewModel
                    print("Sucesss, you're a god")
                }
            } else {
                DispatchQueue.main.async { [self] in
                    // Navigate to the login screen with an error message
                    coordinateToErrorView()
                }
            }
        }
    }

    func coordinateToPeriodView() {
        let viewController = PeriodViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    func coordinateToMenuTabBarView() {
        let viewController = MenuTabBarController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func coordinateToLoginView() {
        let viewModel = LoginViewModel(dataManager, self)
        let viewController = LoginViewController()
        viewController.viewModel = viewModel
        
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
