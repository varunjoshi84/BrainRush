//
//  ProfileViewController.swift
//  BrainRush
//

import UIKit

final class ProfileViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Avatar & Identity
    private let avatarContainer = UIView()
    private let avatarImageView = UIImageView()
    private let editBadgeButton = UIButton(type: .custom)
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    // Stats Summary Card (Level, Total XP, Best Streak)
    private let statsCard = UIView()
    private let levelValLabel = UILabel()
    private let xpValLabel = UILabel()
    private let streakValLabel = UILabel()
    
    // Menu Options
    private let editProfileRow = ProfileMenuItem(iconName: "person", title: "Edit Profile")
    private let achievementsRow = ProfileMenuItem(iconName: "rosette", title: "My Achievements")
    private let progressRow = ProfileMenuItem(iconName: "chart.bar.xaxis", title: "Progress")
    private let logoutRow = ProfileMenuItem(iconName: "rectangle.portrait.and.arrow.right", title: "Logout", isDestructive: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Profile"
        navigationController?.setNavigationBarHidden(true, animated: animated)
        refreshData()
    }
    
    private func setupUI() {
        view.backgroundColor = BrainRushTheme.screenBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Avatar Container
        avatarContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarContainer)
        
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = UIColor.systemGray3
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 45
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(avatarImageView)
        
        editBadgeButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editBadgeButton.tintColor = .white
        editBadgeButton.backgroundColor = BrainRushTheme.primaryPurple
        editBadgeButton.layer.cornerRadius = 14
        editBadgeButton.clipsToBounds = true
        editBadgeButton.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(editBadgeButton)
        
        // Name & Email
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        emailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailLabel.textColor = BrainRushTheme.textSecondary
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)
        
        // Stats Card
        statsCard.applyCardStyle(cornerRadius: 18)
        statsCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsCard)
        
        let statsStack = UIStackView()
        statsStack.axis = .horizontal
        statsStack.distribution = .fillEqually
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        statsCard.addSubview(statsStack)
        
        let col1 = makeStatColumn(iconName: "star.fill", iconColor: BrainRushTheme.gold, title: "Level", valLabel: levelValLabel)
        let col2 = makeStatColumn(iconName: "trophy.fill", iconColor: BrainRushTheme.gold, title: "Total XP", valLabel: xpValLabel)
        let col3 = makeStatColumn(iconName: "flame.fill", iconColor: BrainRushTheme.flameOrange, title: "Best Streak", valLabel: streakValLabel)
        
        statsStack.addArrangedSubview(col1)
        statsStack.addArrangedSubview(col2)
        statsStack.addArrangedSubview(col3)
        
        // Menu Card
        let menuCard = UIView()
        menuCard.applyCardStyle(cornerRadius: 18)
        menuCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(menuCard)
        
        let menuStack = UIStackView(arrangedSubviews: [
            editProfileRow,
            makeDivider(),
            achievementsRow,
            makeDivider(),
            progressRow,
            makeDivider(),
            logoutRow
        ])
        menuStack.axis = .vertical
        menuStack.spacing = 10
        menuStack.translatesAutoresizingMaskIntoConstraints = false
        menuCard.addSubview(menuStack)
        
        NSLayoutConstraint.activate([
            avatarContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            avatarContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarContainer.widthAnchor.constraint(equalToConstant: 90),
            avatarContainer.heightAnchor.constraint(equalToConstant: 90),
            
            avatarImageView.topAnchor.constraint(equalTo: avatarContainer.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarContainer.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor),
            
            editBadgeButton.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor),
            editBadgeButton.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor),
            editBadgeButton.widthAnchor.constraint(equalToConstant: 28),
            editBadgeButton.heightAnchor.constraint(equalToConstant: 28),
            
            nameLabel.topAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: 14),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            statsCard.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 22),
            statsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statsCard.heightAnchor.constraint(equalToConstant: 90),
            
            statsStack.topAnchor.constraint(equalTo: statsCard.topAnchor, constant: 14),
            statsStack.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor, constant: 12),
            statsStack.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor, constant: -12),
            statsStack.bottomAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: -14),
            
            menuCard.topAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: 22),
            menuCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            menuCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            menuCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            menuStack.topAnchor.constraint(equalTo: menuCard.topAnchor, constant: 14),
            menuStack.leadingAnchor.constraint(equalTo: menuCard.leadingAnchor, constant: 16),
            menuStack.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor, constant: -16),
            menuStack.bottomAnchor.constraint(equalTo: menuCard.bottomAnchor, constant: -14)
        ])
    }
    
    private func makeStatColumn(iconName: String, iconColor: UIColor, title: String, valLabel: UILabel) -> UIView {
        let col = UIView()
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = iconColor
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLbl.textColor = BrainRushTheme.textSecondary
        titleLbl.textAlignment = .center
        
        valLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        valLabel.textColor = .black
        valLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [icon, titleLbl, valLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 3
        stack.translatesAutoresizingMaskIntoConstraints = false
        col.addSubview(stack)
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 18),
            stack.centerXAnchor.constraint(equalTo: col.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: col.centerYAnchor)
        ])
        return col
    }
    
    private func makeDivider() -> UIView {
        let v = UIView()
        v.backgroundColor = BrainRushTheme.subtleGray
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return v
    }
    
    private func setupActions() {
        editProfileRow.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        editBadgeButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        achievementsRow.addTarget(self, action: #selector(achievementsTapped), for: .touchUpInside)
        progressRow.addTarget(self, action: #selector(progressTapped), for: .touchUpInside)
        logoutRow.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func refreshData() {
        let player = GameManager.shared.currentPlayer
        nameLabel.text = player.name
        emailLabel.text = player.email
        
        levelValLabel.text = "\(player.level)"
        xpValLabel.text = "\(player.totalXP)"
        streakValLabel.text = "\(player.bestStreak)"
    }
    
    @objc private func editProfileTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc private func achievementsTapped() {
        tabBarController?.selectedIndex = 2
    }
    
    @objc private func progressTapped() {
        let history = GameManager.shared.getQuizHistory()
        let count = history.count
        let alert = UIAlertController(
            title: "Your Progress",
            message: "You have completed \(count) quizzes so far with a lifetime best streak of \(GameManager.shared.currentPlayer.bestStreak)!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Awesome!", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func logoutTapped() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out of BrainRush?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            GameManager.shared.logout()
            NavigationCoordinator.showAuth(from: self)
        }))
        present(alert, animated: true)
    }
}

// MARK: - Profile Menu Row Component
final class ProfileMenuItem: UIControl {
    
    init(iconName: String, title: String, isDestructive: Bool = false) {
        super.init(frame: .zero)
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = isDestructive ? UIColor.systemRed : BrainRushTheme.primaryPurple
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 22).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = isDestructive ? UIColor.systemRed : .black
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = isDestructive ? UIColor.clear : BrainRushTheme.textSecondary
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [icon, label, chevron])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 14
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
