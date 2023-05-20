//
//  SignIn.swift
//  Periodic
//
//  Created by Aimeric on 4/18/23.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol {
    func login(username: String, password: String, completion: @escaping (Bool, String) -> Void)
    func loginButtonTapped(username: String, password: String)
}

struct LoginViewModel: LoginViewModelProtocol {
    private let dataManager: PeriodDataManaging
    let coordinator: PeriodCoordinator


    init(_ dataManager: PeriodDataManager, _ coordinator: PeriodCoordinator) {
        self.dataManager = dataManager
        self.coordinator = coordinator

    }
        func loginButtonTapped(username: String, password: String) {
            coordinator.login(username: username, password: password)
        }
    func login(username: String, password: String, completion: @escaping (Bool, String) -> Void) {
        dataManager.login(username: username, password: password) { [self] success, _ in
            if success {
                DispatchQueue.main.async {
                    // Navigate to the home screen
                    print("Sucesss, you're a god")
                }
            } else {
                DispatchQueue.main.async { [self] in
                    // Navigate to the screen with an error message
                }
            }
        }
    }
}
