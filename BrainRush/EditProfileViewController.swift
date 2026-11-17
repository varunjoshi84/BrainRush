//
//  EditProfileViewController.swift
//  BrainRush
//

import UIKit

final class EditProfileViewController: UIViewController {

    private let avatarContainer = UIView()
    private let avatarImageView = UIImageView()
    private let cameraBadgeView = UIView()
    private let cameraIcon = UIImageView()
    
    private let nameField = UITextField()
    private let emailField = UITextField()
    private let saveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCurrentData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Edit Profile"
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = BrainRushTheme.screenBackground
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(content)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Avatar with Camera Badge
        avatarContainer.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(avatarContainer)
        
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = UIColor.systemGray3
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(avatarImageView)
        
        cameraBadgeView.backgroundColor = BrainRushTheme.primaryPurple
        cameraBadgeView.layer.cornerRadius = 16
        cameraBadgeView.clipsToBounds = true
        cameraBadgeView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(cameraBadgeView)
        
        cameraIcon.image = UIImage(systemName: "camera.fill")
        cameraIcon.tintColor = .white
        cameraIcon.contentMode = .scaleAspectFit
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        cameraBadgeView.addSubview(cameraIcon)
        
        // Input Fields Card
        let fieldsCard = UIView()
        fieldsCard.applyCardStyle(cornerRadius: 18)
        fieldsCard.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(fieldsCard)
        
        styleField(nameField, placeholder: "Full Name", iconName: "person")
        styleField(emailField, placeholder: "Email", iconName: "envelope")
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        
        let fieldsStack = UIStackView(arrangedSubviews: [nameField, emailField])
        fieldsStack.axis = .vertical
        fieldsStack.spacing = 16
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsCard.addSubview(fieldsStack)
        
        // Save Button
        saveButton.applyPrimaryButtonStyle(title: "Save Changes")
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            avatarContainer.topAnchor.constraint(equalTo: content.topAnchor, constant: 36),
            avatarContainer.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            avatarContainer.widthAnchor.constraint(equalToConstant: 100),
            avatarContainer.heightAnchor.constraint(equalToConstant: 100),
            
            avatarImageView.topAnchor.constraint(equalTo: avatarContainer.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarContainer.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor),
            
            cameraBadgeView.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor),
            cameraBadgeView.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor),
            cameraBadgeView.widthAnchor.constraint(equalToConstant: 32),
            cameraBadgeView.heightAnchor.constraint(equalToConstant: 32),
            
            cameraIcon.centerXAnchor.constraint(equalTo: cameraBadgeView.centerXAnchor),
            cameraIcon.centerYAnchor.constraint(equalTo: cameraBadgeView.centerYAnchor),
            cameraIcon.widthAnchor.constraint(equalToConstant: 16),
            cameraIcon.heightAnchor.constraint(equalToConstant: 16),
            
            fieldsCard.topAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: 32),
            fieldsCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            fieldsCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            
            fieldsStack.topAnchor.constraint(equalTo: fieldsCard.topAnchor, constant: 20),
            fieldsStack.leadingAnchor.constraint(equalTo: fieldsCard.leadingAnchor, constant: 16),
            fieldsStack.trailingAnchor.constraint(equalTo: fieldsCard.trailingAnchor, constant: -16),
            fieldsStack.bottomAnchor.constraint(equalTo: fieldsCard.bottomAnchor, constant: -20),
            
            nameField.heightAnchor.constraint(equalToConstant: 48),
            emailField.heightAnchor.constraint(equalToConstant: 48),
            
            saveButton.topAnchor.constraint(equalTo: fieldsCard.bottomAnchor, constant: 36),
            saveButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 54),
            saveButton.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -40)
        ])
    }
    
    private func styleField(_ field: UITextField, placeholder: String, iconName: String) {
        field.placeholder = placeholder
        field.backgroundColor = BrainRushTheme.subtleGray
        field.layer.cornerRadius = 12
        field.font = UIFont.systemFont(ofSize: 15)
        
        let iconView = UIImageView(image: UIImage(systemName: iconName))
        iconView.tintColor = BrainRushTheme.textSecondary
        iconView.contentMode = .center
        iconView.frame = CGRect(x: 12, y: 0, width: 24, height: 24)
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 24))
        leftPadding.addSubview(iconView)
        field.leftView = leftPadding
        field.leftViewMode = .always
    }
    
    private func loadCurrentData() {
        let player = GameManager.shared.currentPlayer
        nameField.text = player.name
        emailField.text = player.email
    }
    
    @objc private func saveTapped() {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !name.isEmpty else {
            showAlert(title: "Required", message: "Name cannot be empty.")
            return
        }
        guard !email.isEmpty, email.contains("@") && email.contains(".") else {
            showAlert(title: "Invalid Email", message: "Please provide a valid email.")
            return
        }
        
        GameManager.shared.updateProfile(name: name, email: email)
        
        let alert = UIAlertController(title: "Saved!", message: "Your profile changes have been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
