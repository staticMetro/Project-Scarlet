//
//  SignInViewController.swift
//  Periodic
//
//  Created by Aimeric on 4/15/23.
//

import Foundation
import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate {
    // Refer to this for Google Integration: https://swiftsenpai.com/development/google-sign-in-integration/
    // Client ID: 639825071431-6jva9epk4biiotrjtvn731jgrbj3juuh.apps.googleusercontent.com
    // MARK: - Properties
    private var firstNameTextField = UITextField()
    private var lastNameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var passwordConfirmTextField = UITextField()
    private var loginStackView = UIStackView()
    var viewModel: LoginViewModelProtocol?
    var signInUpButton = SocialLoginButton(text: "")
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupUI()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @objc func loginButtonTapped() {
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        if title == "Register" {
            signInUpButton.removeTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
            signInUpButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        }
        viewModel?.loginButtonTapped(username: email, password: password)
    }
    @objc func registerButtonTapped() {
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        _ = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordConfirm = passwordConfirmTextField.text else {
            return
        }
        viewModel?.registerButtonTapped(firstName, lastName, email, password, passwordConfirm)
    }

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
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Sign in", "Register"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//            segmentedControl.tintColor = UIColor.systemPink
        segmentedControl.selectedSegmentIndex = 0
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        firstNameTextField.isHidden = true
        lastNameTextField.isHidden = true
        passwordConfirmTextField.isHidden = true
        segmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return segmentedControl
    }()
    @objc func handleLoginRegisterChange() {
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        signInUpButton.setTitleColor(.systemPink, for: .normal)
        signInUpButton.setTitle(title, for: .normal)

        firstNameTextField.isHidden = (selectedIndex == 1) ? false : true
        lastNameTextField.isHidden = (selectedIndex == 1) ? false : true
        passwordConfirmTextField.isHidden = (selectedIndex == 1) ? false : true

    }
// MARK: - Private Methods
    private func setupSubviews() {
        view.addSubview(loginStackView)
        loginStackView.addArrangedSubview(loginRegisterSegmentedControl)
        loginStackView.addArrangedSubview(firstNameTextField)
        loginStackView.addArrangedSubview(lastNameTextField)
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(passwordConfirmTextField)
        loginStackView.addArrangedSubview(appleLoginButton)
        loginStackView.addArrangedSubview(signInUpButton)
    }
    private func setupUI() {
        loginStackView.alignment = .center
        loginStackView.spacing = 10
        loginStackView.distribution = .fillEqually
        loginStackView.axis = .vertical
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        firstNameTextField.textAlignment = .center
        firstNameTextField.backgroundColor = .secondarySystemBackground
        firstNameTextField.layer.cornerRadius = 9
        firstNameTextField.layer.borderWidth = 1
        firstNameTextField.keyboardType = .default
        firstNameTextField.autocapitalizationType = .none
        firstNameTextField.textColor = .systemPink
        
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lastNameTextField.textAlignment = .center
        lastNameTextField.backgroundColor = .secondarySystemBackground
        lastNameTextField.layer.cornerRadius = 9
        lastNameTextField.layer.borderWidth = 1
        lastNameTextField.keyboardType = .default
        lastNameTextField.autocapitalizationType = .none
        lastNameTextField.textColor = .systemPink
        
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        emailTextField.textAlignment = .center
        emailTextField.backgroundColor = .tertiarySystemGroupedBackground
        emailTextField.layer.cornerRadius = 9
        emailTextField.layer.borderWidth = 1
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textColor = .systemPink

        
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        passwordTextField.textAlignment = .center
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.layer.cornerRadius = 9
        passwordTextField.layer.borderWidth = 1
        passwordTextField.keyboardType = .default
        passwordTextField.autocapitalizationType = .none
        passwordTextField.textColor = .systemPink

        
        passwordConfirmTextField.placeholder = "Password Confirm"
        passwordConfirmTextField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        passwordConfirmTextField.textAlignment = .center
        passwordConfirmTextField.backgroundColor = .secondarySystemBackground
        passwordConfirmTextField.layer.cornerRadius = 9
        passwordConfirmTextField.layer.borderWidth = 1
        passwordConfirmTextField.keyboardType = .default
        passwordConfirmTextField.autocapitalizationType = .none
        passwordConfirmTextField.textColor = .systemPink

    }
    private func setupViews() {
        view.backgroundColor = .systemBackground
        let signInLabel = UILabel()
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .systemPink
        
        view.addSubview(signInLabel)
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        signInUpButton.setTitle(title, for: .normal)
        signInUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

            signInLabel.translatesAutoresizingMaskIntoConstraints = false
            signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            signInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16).isActive = true
            signInLabel.trailingAnchor.constraint(equalTo:
                                                    view.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -16).isActive = true
//        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50).isActive = true
//
//            emailTextField.translatesAutoresizingMaskIntoConstraints = false
//            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor , constant: 10).isActive = true
//            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//            appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
//        appleLoginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor , constant: 10).isActive = true
//            appleLoginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,
//                                                    multiplier: 0.9).isActive = true
//            appleLoginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//            appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//            appleLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            signInUpButton.translatesAutoresizingMaskIntoConstraints = false
//            signInUpButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 40).isActive = true
//            signInUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,
//                                                multiplier: 0.9).isActive = true
//            signInUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//            signInUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            loginStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginStackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50),
            loginStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 300),

            firstNameTextField.widthAnchor.constraint(equalToConstant: 250),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 250),
            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordConfirmTextField.widthAnchor.constraint(equalToConstant: 250),
            
//            signInUpButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 40),
            signInUpButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor, multiplier: 0.4),
            signInUpButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
class SocialLoginButton: UIButton {
    private let textLabel = UILabel()
    init(text: String) {
        super.init(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 20)
        let stackView = UIStackView(arrangedSubviews: [textLabel])
        stackView.alignment = .center
        stackView.spacing = 8
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 60
        layer.shadowOffset = CGSize(width: 0, height: 16)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
