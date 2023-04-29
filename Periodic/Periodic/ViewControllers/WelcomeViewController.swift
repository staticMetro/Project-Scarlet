//
//  WelcomeViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/15/23.
//

import Foundation
import UIKit

class WelcomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .systemBackground

        let imageView = UIImageView(image: UIImage(named: "onboard"))
        imageView.contentMode = .scaleAspectFit

        let primaryButton = PrimaryButton()
        primaryButton.setTitle("Get Started", for: .normal)

        let signInButton = UIButton()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        signInButton.setTitleColor(UIColor(named: "PrimaryColor"), for: .normal)
        signInButton.backgroundColor = .systemBackground
        signInButton.layer.cornerRadius = 50.0
//        signInButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
//        signInButton.layer.shadowRadius = 60
//        signInButton.layer.shadowOffset = CGSize(width: 0, height: 16)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        let newAroundHereLabel = UILabel()
        newAroundHereLabel.text = "New around here? "
        newAroundHereLabel.textColor = .secondaryLabel

        let signUpLabel = UILabel()
        signUpLabel.text = "Sign Up"
        signUpLabel.textColor = UIColor(named: "PrimaryColor")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInButtonTapped))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapGesture)
        let stackViewHorizontal = UIStackView(arrangedSubviews: [newAroundHereLabel, signUpLabel])
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 15
        stackViewHorizontal.alignment = .center
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [imageView, primaryButton, signInButton, stackViewHorizontal])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -15),
            stackViewHorizontal.topAnchor.constraint(equalTo: signInButton.bottomAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }

    @objc func signInButtonTapped() {
        let signInScreen = LoginViewController()
        signInScreen.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(signInScreen, animated: true)
    }

}

class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureButton() {
        backgroundColor = UIColor(named: "PrimaryColor")
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        layer.cornerRadius = 10
        layer.borderWidth = 2
//        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
//        layer.shadowRadius = 60
//        layer.shadowOffset = CGSize(width: 0, height: 16)
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: 240).isActive = true
    }
}
