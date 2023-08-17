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
        loginRegisterSegmentedControl.selectedSegmentIndex = 0
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
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 16
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
    private func setupTextField(_ textField: UITextField, _ textFieldName: String) {
        textField.placeholder = textFieldName
        textField.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textField.textAlignment = .center
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 18
        textField.layer.borderWidth = 1
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.textColor = .systemPink
    }
    private func setupUI() {
        loginStackView.alignment = .center
        loginStackView.spacing = 10
        loginStackView.distribution = .fillEqually
        loginStackView.axis = .vertical
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        setupTextField(firstNameTextField, "First Name")
        setupTextField(lastNameTextField, "Last Name")
        setupTextField(emailTextField, "Email")
        setupTextField(passwordTextField, "Password")
        setupTextField(passwordConfirmTextField, "Password Confirm")
    }
    private func setupViews() {
        view.backgroundColor = .systemBackground
        let signInLabel = UILabel()
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: selectedIndex)
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .systemPink
        view.addSubview(signInLabel)
        signInUpButton.layer.cornerRadius = 18
        signInUpButton.setTitle(title, for: .normal)
        signInUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        signInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                             constant: 16).isActive = true
        signInLabel.trailingAnchor.constraint(equalTo:
                                                view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -16).isActive = true
        signInUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginStackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50),
            loginStackView.bottomAnchor.constraint(lessThanOrEqualTo:
                                                    view.safeAreaLayoutGuide.bottomAnchor, constant: 300),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 250),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 250),
            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordConfirmTextField.widthAnchor.constraint(equalToConstant: 250),
            signInUpButton.widthAnchor.constraint(equalTo: loginStackView.widthAnchor, multiplier: 0.75),
            signInUpButton.heightAnchor.constraint(equalToConstant: 40)
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
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 60
        layer.shadowOffset = CGSize(width: 0, height: 16)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
