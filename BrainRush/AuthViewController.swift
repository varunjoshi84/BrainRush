//
//  AuthViewController.swift
//  BrainRush
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let segmentedControl = UISegmentedControl(items: ["Login", "Register"])
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Login Views
    private let loginCard = UIView()
    private let loginTitle = UILabel()
    private let loginSubtitle = UILabel()
    private let loginEmailField = UITextField()
    private let loginPasswordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let forgotPasswordButton = UIButton(type: .system)
    
    // Register Views
    private let registerCard = UIView()
    private let registerTitle = UILabel()
    private let registerSubtitle = UILabel()
    private let regNameField = UITextField()
    private let regEmailField = UITextField()
    private let regPasswordField = UITextField()
    private let regConfirmPasswordField = UITextField()
    private let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = BrainRushTheme.primaryPurple
        
        // Header title
        let appTitle = UILabel()
        appTitle.text = "BrainRush"
        appTitle.textColor = .white
        appTitle.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        appTitle.textAlignment = .center
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appTitle)
        
        // Segmented Control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = BrainRushTheme.primaryPurple
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15, weight: .bold)], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Scroll & Content View for White Cards
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 240),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        setupLoginCard()
        setupRegisterCard()
        
        // Initially show login
        loginCard.isHidden = false
        registerCard.isHidden = true
    }
    
    private func setupLoginCard() {
        loginCard.backgroundColor = .white
        loginCard.layer.cornerRadius = 28
        loginCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loginCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginCard)
        
        loginTitle.text = "Welcome Back!"
        loginTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        loginTitle.textColor = .black
        loginTitle.textAlignment = .center
        
        loginSubtitle.text = "Login to continue your journey"
        loginSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        loginSubtitle.textColor = BrainRushTheme.textSecondary
        loginSubtitle.textAlignment = .center
        
        styleTextField(loginEmailField, placeholder: "Email", iconName: "envelope")
        loginEmailField.keyboardType = .emailAddress
        loginEmailField.autocapitalizationType = .none
        
        styleTextField(loginPasswordField, placeholder: "Password", iconName: "lock", isSecure: true)
        
        loginButton.applyPrimaryButtonStyle(title: "Login")
        
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(BrainRushTheme.primaryPurple, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        let stack = UIStackView(arrangedSubviews: [
            loginTitle,
            loginSubtitle,
            spacer(height: 12),
            loginEmailField,
            loginPasswordField,
            spacer(height: 8),
            loginButton,
            forgotPasswordButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        loginCard.addSubview(stack)
        
        NSLayoutConstraint.activate([
            loginCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            loginCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loginCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loginCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 580),
            
            stack.topAnchor.constraint(equalTo: loginCard.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: loginCard.leadingAnchor, constant: 28),
            stack.trailingAnchor.constraint(equalTo: loginCard.trailingAnchor, constant: -28),
            
            loginEmailField.heightAnchor.constraint(equalToConstant: 52),
            loginPasswordField.heightAnchor.constraint(equalToConstant: 52),
            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func setupRegisterCard() {
        registerCard.backgroundColor = .white
        registerCard.layer.cornerRadius = 28
        registerCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        registerCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(registerCard)
        
        registerTitle.text = "Create Account"
        registerTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        registerTitle.textColor = .black
        registerTitle.textAlignment = .center
        
        registerSubtitle.text = "Join BrainRush and start learning"
        registerSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        registerSubtitle.textColor = BrainRushTheme.textSecondary
        registerSubtitle.textAlignment = .center
        
        styleTextField(regNameField, placeholder: "Full Name", iconName: "person")
        styleTextField(regEmailField, placeholder: "Email", iconName: "envelope")
        regEmailField.keyboardType = .emailAddress
        regEmailField.autocapitalizationType = .none
        
        styleTextField(regPasswordField, placeholder: "Password", iconName: "lock", isSecure: true)
        styleTextField(regConfirmPasswordField, placeholder: "Confirm Password", iconName: "lock", isSecure: true)
        
        registerButton.applyPrimaryButtonStyle(title: "Register")
        
        let stack = UIStackView(arrangedSubviews: [
            registerTitle,
            registerSubtitle,
            spacer(height: 12),
            regNameField,
            regEmailField,
            regPasswordField,
            regConfirmPasswordField,
            spacer(height: 8),
            registerButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        registerCard.addSubview(stack)
        
        NSLayoutConstraint.activate([
            registerCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            registerCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            registerCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            registerCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            registerCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 640),
            
            stack.topAnchor.constraint(equalTo: registerCard.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: registerCard.leadingAnchor, constant: 28),
            stack.trailingAnchor.constraint(equalTo: registerCard.trailingAnchor, constant: -28),
            
            regNameField.heightAnchor.constraint(equalToConstant: 52),
            regEmailField.heightAnchor.constraint(equalToConstant: 52),
            regPasswordField.heightAnchor.constraint(equalToConstant: 52),
            regConfirmPasswordField.heightAnchor.constraint(equalToConstant: 52),
            registerButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func styleTextField(_ field: UITextField, placeholder: String, iconName: String, isSecure: Bool = false) {
        field.placeholder = placeholder
        field.backgroundColor = BrainRushTheme.subtleGray
        field.layer.cornerRadius = 14
        field.font = UIFont.systemFont(ofSize: 15)
        field.isSecureTextEntry = isSecure
        
        let iconView = UIImageView(image: UIImage(systemName: iconName))
        iconView.tintColor = BrainRushTheme.textSecondary
        iconView.contentMode = .center
        iconView.frame = CGRect(x: 14, y: 0, width: 24, height: 24)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
        leftPaddingView.addSubview(iconView)
        field.leftView = leftPaddingView
        field.leftViewMode = .always
        
        if isSecure {
            let eyeBtn = UIButton(type: .custom)
            eyeBtn.setImage(UIImage(systemName: "eye"), for: .normal)
            eyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .selected)
            eyeBtn.tintColor = BrainRushTheme.textSecondary
            eyeBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 24)
            eyeBtn.addAction(UIAction(handler: { _ in
                eyeBtn.isSelected.toggle()
                field.isSecureTextEntry = !eyeBtn.isSelected
            }), for: .touchUpInside)
            field.rightView = eyeBtn
            field.rightViewMode = .always
        }
    }
    
    private func spacer(height: CGFloat) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: height).isActive = true
        return v
    }
    
    private func setupActions() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
    }
    
    @objc private func segmentChanged() {
        let isLogin = segmentedControl.selectedSegmentIndex == 0
        loginCard.isHidden = !isLogin
        registerCard.isHidden = isLogin
        view.endEditing(true)
    }
    
    @objc private func handleLogin() {
        let email = loginEmailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = loginPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !email.isEmpty else {
            showAlert(title: "Required", message: "Please enter your email.")
            return
        }
        guard email.contains("@") && email.contains(".") else {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        guard !password.isEmpty else {
            showAlert(title: "Required", message: "Please enter your password.")
            return
        }
        
        GameManager.shared.login(name: "Varun Joshi", email: email)
        NavigationCoordinator.showMainApp(from: self)
    }
    
    @objc private func handleRegister() {
        let name = regNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = regEmailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = regPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let confirm = regConfirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !name.isEmpty else {
            showAlert(title: "Required", message: "Please enter your full name.")
            return
        }
        guard !email.isEmpty, email.contains("@") && email.contains(".") else {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        guard !password.isEmpty else {
            showAlert(title: "Required", message: "Please choose a password.")
            return
        }
        guard password == confirm else {
            showAlert(title: "Mismatch", message: "Passwords do not match.")
            return
        }
        
        GameManager.shared.register(name: name, email: email)
        NavigationCoordinator.showMainApp(from: self)
    }
    
    @objc private func handleForgotPassword() {
        showAlert(title: "Reset Password", message: "Password reset instructions have been sent to your email.")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
