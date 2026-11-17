//
//  ViewController.swift
//  BrainRush
//
//  Entry point linked from Main.storyboard (Splash Screen)
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Auto-advance after 1.5 seconds delay like standard iOS splash
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.navigateToNext()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = BrainRushTheme.primaryPurple
        
        // Clear any placeholder subviews from storyboard
        view.subviews.forEach { $0.removeFromSuperview() }
        
        // Container stack for logo, titles, and activity indicator
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        let iconView = UIImageView(image: UIImage(systemName: "brain.head.profile"))
        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "BrainRush"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Quiz • Learn • Level Up"
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        spinner.startAnimating()
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        loadingLabel.font = UIFont.systemFont(ofSize: 14)
        
        stack.addArrangedSubview(iconView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        stack.addArrangedSubview(spacer)
        stack.addArrangedSubview(spinner)
        stack.addArrangedSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func navigateToNext() {
        if GameManager.shared.isLoggedIn {
            NavigationCoordinator.showMainApp(from: self)
        } else {
            NavigationCoordinator.showAuth(from: self)
        }
    }
}
