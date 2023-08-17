//
//  SettingsViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/15/23.
//

import UIKit
import Setting
import SwiftUI

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsViewController = UIHostingController(rootView: SettingsView())
        present(settingsViewController, animated: true)
    }
    
}
struct SettingsView: View {
    var body: some View {
        SettingStack {
            SettingPage(title: "Settings") {
                SettingGroup {
                    SettingPage(title: "General") {}
                        .previewIcon("gear")
                }

                SettingGroup {
                    SettingPage(title: "HealthKit") {}
                        .previewIcon("heart", color: .pink)

                    SettingPage(title: "Notifications") {}
                        .previewIcon("bell.badge.fill", color: .orange)

                    SettingPage(title: "About the Developers") {}
                        .previewIcon("person.fill", color: .teal)
                }
            }
        }

    }
}
