//
//  SignInViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/15/23.
//

import Foundation
import UIKit
import AuthenticationServices
import GoogleSignIn

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate {
    // Refer to this for Google Integration: https://swiftsenpai.com/development/google-sign-in-integration/
    // Client ID: 639825071431-6jva9epk4biiotrjtvn731jgrbj3juuh.apps.googleusercontent.com
    
    // MARK: - Properties
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var viewModel = LoginViewModel()
    
    lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    @objc func appleLoginButtonTapped() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        Let GIDSignIn know that this view controller is presenter of the sign-in sheet
//        GIDSignIn.sharedInstance.signIn(withPresenting: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @objc func googleLoginButtonTapped() {
//        GIDSignIn.sharedInstance.signIn(withPresenting: self)
        print("success")
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        let signInLabel = UILabel()
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .systemPink
        
        view.addSubview(signInLabel)
        view.addSubview(appleLoginButton)
        let googleButton = SocialLoginButton(image: UIImage(named: "google")!, text: "Sign in with Google")
        googleButton.addTarget(googleButton, action: #selector(googleLoginButtonTapped), for: .touchUpInside)
        googleButton.setTitleColor(.systemPink, for: .normal)
        view.addSubview(googleButton)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        emailTextField.textAlignment = .left
        emailTextField.backgroundColor = .tertiarySystemGroupedBackground
        emailTextField.layer.cornerRadius = 9
        emailTextField.layer.borderWidth = 3
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        passwordTextField.textAlignment = .left
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.layer.cornerRadius = 9
        passwordTextField.layer.borderWidth = 3
        passwordTextField.keyboardType = .default
        passwordTextField.autocapitalizationType = .none
        view.addSubview(passwordTextField)
// Constraintss
        func setUpConstraints(){
            signInLabel.translatesAutoresizingMaskIntoConstraints = false
            signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
            signInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16).isActive = true
            signInLabel.trailingAnchor.constraint(equalTo:
                                                    view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -16).isActive = true
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50).isActive = true
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
            appleLoginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
            appleLoginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.9).isActive = true
            appleLoginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            appleLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            
            googleButton.translatesAutoresizingMaskIntoConstraints = false
            googleButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 40).isActive = true
            googleButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.9).isActive = true
            googleButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            googleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
        
    }
}
class SocialLoginButton: UIButton {
    override var imageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemPink
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
