//
//  UserModel.swift
//  Periodic
//
//  Created by Aimeric on 4/21/23.
//

import Foundation
import UIKit

struct UserModel: Codable {
    let email: String?
    let firstName: String?
    let lastName: String?
    let password: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case password = "password"
    }
}
