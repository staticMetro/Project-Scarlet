//
//  Extensions.swift
//  Periodic
//
//  Created by Aimeric on 4/11/23.
//

import Foundation
import UIKit

extension UIImageView {
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

