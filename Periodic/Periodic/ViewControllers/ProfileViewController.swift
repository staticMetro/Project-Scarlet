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
//        let swiftUIViewController = UIHostingController(rootView: SetingsView())
//        self.navigationController?.pushViewController(swiftUIViewController, animated: false)
//        self.navigationController?.pushViewController(swiftUIViewController, animated: false)
    }
    
}
struct ProfileViewController: View {
    var body: some View {
        SettingStack {
            SettingPage(title: "Playground") {
                SettingGroup {
                    SettingText(title: "Hello!")
                }

                SettingGroup {
                    SettingPage(title: "First Page") {}
                        .previewIcon("star")

                    SettingPage(title: "Second Page") {}
                        .previewIcon("sparkles")

                    SettingPage(title: "Third Page") {}
                        .previewIcon("leaf.fill")
                }
            }
        }

    }
}
