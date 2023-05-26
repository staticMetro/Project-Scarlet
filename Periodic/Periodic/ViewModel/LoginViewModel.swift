//
//  SignIn.swift
//  Periodic
//
//  Created by Aimeric on 4/18/23.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol {
    func loginButtonTapped(username: String, password: String)
    func registerButtonTapped(_ firstName: String,_ lastName: String, _ email: String, _ password: String, _ passwordConfirm: String)
}

struct LoginViewModel: LoginViewModelProtocol {
    private let dataManager: PeriodDataManaging
    private let coordinator: PeriodCoordinator

    init(_ dataManager: PeriodDataManager, _ coordinator: PeriodCoordinator) {
        self.dataManager = dataManager
        self.coordinator = coordinator
    }
    func loginButtonTapped(username: String, password: String) {
        coordinator.login(username: username, password: password)
    }
    func registerButtonTapped(_ firstName: String,_ lastName: String, _ email: String, _ password: String, _ passwordConfirm: String) {
        coordinator.register(firstName: firstName, lastName: lastName, email: email, password: password, passwordConfirm: passwordConfirm)
    }
}
