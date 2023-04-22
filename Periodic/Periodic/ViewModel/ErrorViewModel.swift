//
//  ErrorViewModel.swift
//  Periodic
//
//  Created by Aimeric on 4/21/23.
//

import Foundation

protocol ErrorViewModelProtocol {
    func handleAction(action: ErrorViewModelAction)
}

enum ErrorViewModelAction {
    case exit
}

struct ErrorViewModel: ErrorViewModelProtocol {
    func handleAction(action: ErrorViewModelAction) {
        endClosure?(action)
    }

    var endClosure: ((ErrorViewModelAction) -> Void)?
}
