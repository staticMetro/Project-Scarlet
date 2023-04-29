//
//  UserModel.swift
//  Periodic
//
//  Created by Aimeric on 4/21/23.
//

import Foundation
import UIKit

struct UserModel: Codable {
    let id: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    let password: String?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName
        case lastName
        case password
        case token

    }
}
