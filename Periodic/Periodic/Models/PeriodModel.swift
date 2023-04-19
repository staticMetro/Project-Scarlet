//
//  PeriodModel.swift
//  Periodic
//
//  Created by Aimeric on 4/9/23.
//

import Foundation
import UIKit

struct PeriodModel: Codable {
    let periodStartDate: String?
    let periodEndDate: String?
    let fertileStart: String?
    let fertileEnd: String?

    enum CodingKeys: String, CodingKey {
        case periodStartDate
        case periodEndDate
        case fertileStart
        case fertileEnd
    }
}
