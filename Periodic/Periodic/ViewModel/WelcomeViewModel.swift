//
//  WelcomeViewModel.swift
//  Periodic
//
//  Created by Aimeric on 5/5/23.
//

import Foundation

protocol WelcomeViewModelProtocol {
    func handleAction(action: WelcomeViewModelAction)
}

enum WelcomeViewModelAction {
    case exit
}

struct WelcomeViewModel: WelcomeViewModelProtocol {
    func handleAction(action: WelcomeViewModelAction) {
        endClosure?(action)
    }

    var endClosure: ((WelcomeViewModelAction) -> Void)?
}
