//
//  SignInViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/15/23.
//

import Foundation
import UIKit

class SignInScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let signInLabel = UILabel()
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .black
        view.addSubview(signInLabel)
        
        let appleButton = SocialLoginButton(image: UIImage(named: "apple")!, text: "Sign in with Apple")
        view.addSubview(appleButton)
        
        let googleButton = SocialLoginButton(image: UIImage(named: "google")!, text: "Sign in with Google")
        googleButton.setTitleColor(UIColor(named: "PrimaryColor"), for: .normal)
        view.addSubview(googleButton)
        
        let emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        emailLabel.textColor = .secondarySystemFill
        emailLabel.textAlignment = .center
        view.addSubview(emailLabel)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        emailTextField.backgroundColor = .systemBackground
        emailTextField.layer.cornerRadius = 50
        emailTextField.layer.cornerRadius = 10

        emailTextField.layer.shadowColor = UIColor.black.cgColor
        emailTextField.layer.shadowOpacity = 0.08
        emailTextField.layer.shadowRadius = 60
        emailTextField.layer.shadowOffset = CGSize(width: 0, height: 16)
        emailTextField.textAlignment = .center
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        passwordLabel.textColor = .secondarySystemFill
        passwordLabel.textAlignment = .center
        view.addSubview(passwordLabel)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = " "
        passwordTextField.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        passwordTextField.backgroundColor = .gray
        passwordTextField.layer.cornerRadius = 50
        passwordTextField.layer.shadowColor = UIColor.black.cgColor
        passwordTextField.layer.shadowOpacity = 0.08
        passwordTextField.layer.shadowRadius = 60
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 16)
        passwordTextField.textAlignment = .center
        passwordTextField.keyboardType = .default
        passwordTextField.autocapitalizationType = .none
        view.addSubview(passwordTextField)
//        let emailButton = PrimaryButton()
//        emailButton.setTitle("Email me a signup link", for: .normal)
//        view.addSubview(emailButton)
        
        let safeLabel = UILabel()
        safeLabel.text = "You are completely safe."
        safeLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        safeLabel.textColor = .secondaryLabel
        safeLabel.textAlignment = .center
        view.addSubview(safeLabel)
        
        let termsButton = UIButton()
        termsButton.setTitle("Read our Terms & Conditions.", for: .normal)
        termsButton.setTitleColor(UIColor(named: "PrimaryColor"), for: .normal)
        view.addSubview(termsButton)
        
        // Constraints
        
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        signInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
//        appleButton.translatesAutoresizingMaskIntoConstraints = false
//        appleButton.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50).isActive = true
//        appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
//        googleButton.translatesAutoresizingMaskIntoConstraints = false
//        googleButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 10).isActive = true
//        googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}
class SocialLoginButton: UIButton {
    
    override var imageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.tintColor = .
        return imageView
    }
    private let textLabel = UILabel()
    
    init(image: UIImage, text: String) {
        super.init(frame: .zero)
        
        imageView.image = image
        
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textColor = .secondaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.alignment = .center
        stackView.spacing = 8
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        backgroundColor = .white
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 60
        layer.shadowOffset = CGSize(width: 0, height: 16)
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

                                                
