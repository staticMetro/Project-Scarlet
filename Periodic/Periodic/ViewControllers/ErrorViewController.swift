//
//  ErrorViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/21/23.
//

import Foundation
import UIKit

class ErrorViewController: UIViewController {
    private let errorImageView = UIImageView()
    private let label = UILabel()
    private let tryAgainButton = UIButton()
    var viewModel: ErrorViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureErrorUI()
        addConstraints()
    }
    func configureErrorUI() {
        errorImageView.image = UIImage(named: "onboard")
        tryAgainButton.setTitle("Try Again", for: .normal)
        label.text = "Oops something went wrong! Please try again later."
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        tryAgainButton.backgroundColor = .systemPink
        tryAgainButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)

        view.addSubview(tryAgainButton)
        view.addSubview(errorImageView)
        view.addSubview(label)
        view.backgroundColor = .systemBackground
    }

    @objc func buttonPressed(sender: UIButton) {
        viewModel?.handleAction(action: .exit)
    }

    func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.contentMode = .scaleAspectFit

        constraints.append(errorImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        // swiftlint:disable all
        constraints.append(errorImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200))
        constraints.append(errorImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(errorImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(errorImageView.heightAnchor.constraint(equalTo: errorImageView.widthAnchor, multiplier: 0.9))

        constraints.append(label.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: -150))
        constraints.append(label.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150))
        constraints.append(label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40))
        constraints.append(label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60))

        constraints.append(tryAgainButton.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 1))
        constraints.append(tryAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 1))
        constraints.append(tryAgainButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50))
        constraints.append(tryAgainButton.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.01))
        constraints.append(tryAgainButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        // swiftlint:enable all
        NSLayoutConstraint.activate(constraints)
    }
}
