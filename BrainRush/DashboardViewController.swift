//
//  DashboardViewController.swift
//  BrainRush
//

import UIKit

final class DashboardViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Top Greeting
    private let greetingLabel = UILabel()
    private let bellButton = UIButton(type: .system)
    
    // Level Progress Card
    private let levelCard = UIView()
    private let levelBadgeView = UIView()
    private let levelStarIcon = UIImageView()
    private let levelLabel = UILabel()
    private let xpProgressLabel = UILabel()
    private let xpProgressBar = UIProgressView(progressViewStyle: .default)
    
    // 3 Quick Stats Badges
    private let streakCard = UIView()
    private let streakValLabel = UILabel()
    
    private let xpCard = UIView()
    private let xpValLabel = UILabel()
    
    private let badgesCard = UIView()
    private let badgesValLabel = UILabel()
    
    // Quick Action Cards
    private let playQuizAction = QuickActionView(
        iconName: "play.circle.fill",
        iconColor: BrainRushTheme.primaryPurple,
        title: "Play Quiz",
        subtitle: "Choose a topic and start"
    )
    
    private let achievementsAction = QuickActionView(
        iconName: "rosette",
        iconColor: BrainRushTheme.gold,
        title: "Achievements",
        subtitle: "View your badges"
    )
    
    private let profileAction = QuickActionView(
        iconName: "person.circle.fill",
        iconColor: BrainRushTheme.accentPurple,
        title: "Profile",
        subtitle: "Manage your account"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        // Header
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerStack)
        
        greetingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        greetingLabel.textColor = .black
        headerStack.addArrangedSubview(greetingLabel)
        
        bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
        bellButton.tintColor = .black
        headerStack.addArrangedSubview(bellButton)
        
        // Level Card (Purple Banner)
        levelCard.backgroundColor = BrainRushTheme.primaryPurple
        levelCard.layer.cornerRadius = 20
        levelCard.layer.masksToBounds = true
        levelCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(levelCard)
        
        levelStarIcon.image = UIImage(systemName: "star.fill")
        levelStarIcon.tintColor = BrainRushTheme.gold
        levelStarIcon.translatesAutoresizingMaskIntoConstraints = false
        
        levelLabel.textColor = .white
        levelLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        xpProgressLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        xpProgressLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        xpProgressLabel.textAlignment = .right
        xpProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        xpProgressBar.progressTintColor = UIColor.white
        xpProgressBar.trackTintColor = UIColor.white.withAlphaComponent(0.25)
        xpProgressBar.layer.cornerRadius = 6
        xpProgressBar.clipsToBounds = true
        xpProgressBar.translatesAutoresizingMaskIntoConstraints = false
        
        levelCard.addSubview(levelStarIcon)
        levelCard.addSubview(levelLabel)
        levelCard.addSubview(xpProgressLabel)
        levelCard.addSubview(xpProgressBar)
        
        NSLayoutConstraint.activate([
            levelStarIcon.leadingAnchor.constraint(equalTo: levelCard.leadingAnchor, constant: 16),
            levelStarIcon.topAnchor.constraint(equalTo: levelCard.topAnchor, constant: 16),
            levelStarIcon.widthAnchor.constraint(equalToConstant: 28),
            levelStarIcon.heightAnchor.constraint(equalToConstant: 28),
            
            levelLabel.centerYAnchor.constraint(equalTo: levelStarIcon.centerYAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: levelStarIcon.trailingAnchor, constant: 10),
            
            xpProgressLabel.centerYAnchor.constraint(equalTo: levelStarIcon.centerYAnchor),
            xpProgressLabel.trailingAnchor.constraint(equalTo: levelCard.trailingAnchor, constant: -16),
            
            xpProgressBar.topAnchor.constraint(equalTo: levelStarIcon.bottomAnchor, constant: 16),
            xpProgressBar.leadingAnchor.constraint(equalTo: levelCard.leadingAnchor, constant: 16),
            xpProgressBar.trailingAnchor.constraint(equalTo: levelCard.trailingAnchor, constant: -16),
            xpProgressBar.bottomAnchor.constraint(equalTo: levelCard.bottomAnchor, constant: -18),
            xpProgressBar.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        // 3 Stats Stack
        let statsStack = UIStackView()
        statsStack.axis = .horizontal
        statsStack.distribution = .fillEqually
        statsStack.spacing = 14
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsStack)
        
        setupStatCard(card: streakCard, iconName: "flame.fill", iconColor: BrainRushTheme.flameOrange, title: "Streak", valueLabel: streakValLabel)
        setupStatCard(card: xpCard, iconName: "trophy.fill", iconColor: BrainRushTheme.gold, title: "Total XP", valueLabel: xpValLabel)
        setupStatCard(card: badgesCard, iconName: "rosette", iconColor: BrainRushTheme.primaryPurple, title: "Badges", valueLabel: badgesValLabel)
        
        statsStack.addArrangedSubview(streakCard)
        statsStack.addArrangedSubview(xpCard)
        statsStack.addArrangedSubview(badgesCard)
        
        // Actions Stack
        let actionsStack = UIStackView(arrangedSubviews: [playQuizAction, achievementsAction, profileAction])
        actionsStack.axis = .vertical
        actionsStack.spacing = 14
        actionsStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionsStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            levelCard.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
            levelCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            levelCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            statsStack.topAnchor.constraint(equalTo: levelCard.bottomAnchor, constant: 18),
            statsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statsStack.heightAnchor.constraint(equalToConstant: 100),
            
            actionsStack.topAnchor.constraint(equalTo: statsStack.bottomAnchor, constant: 24),
            actionsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            actionsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupStatCard(card: UIView, iconName: String, iconColor: UIColor, title: String, valueLabel: UILabel) {
        card.applyCardStyle(cornerRadius: 16)
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = iconColor
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLbl.textColor = BrainRushTheme.textSecondary
        titleLbl.textAlignment = .center
        
        valueLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [icon, titleLbl, valueLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stack)
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 22),
            icon.heightAnchor.constraint(equalToConstant: 22),
            stack.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: card.centerYAnchor)
        ])
    }
    
    private func setupActions() {
        playQuizAction.addTarget(self, action: #selector(navigateToTopics), for: .touchUpInside)
        achievementsAction.addTarget(self, action: #selector(navigateToAchievements), for: .touchUpInside)
        profileAction.addTarget(self, action: #selector(navigateToProfile), for: .touchUpInside)
        bellButton.addTarget(self, action: #selector(notificationsTapped), for: .touchUpInside)
    }
    
    private func refreshData() {
        let player = GameManager.shared.currentPlayer
        let firstName = player.name.components(separatedBy: " ").first ?? "Player"
        greetingLabel.text = "Hello, \(firstName)! 👋"
        
        levelLabel.text = "Level \(player.level)"
        xpProgressLabel.text = "\(player.totalXP) / \(player.nextLevelXP) XP"
        xpProgressBar.setProgress(player.levelProgressFraction, animated: true)
        
        streakValLabel.text = "\(player.currentStreak)"
        xpValLabel.text = "\(player.totalXP)"
        badgesValLabel.text = "\(player.unlockedBadgeIds.count)"
    }
    
    @objc private func navigateToTopics() {
        tabBarController?.selectedIndex = 1
    }
    
    @objc private func navigateToAchievements() {
        tabBarController?.selectedIndex = 2
    }
    
    @objc private func navigateToProfile() {
        tabBarController?.selectedIndex = 3
    }
    
    @objc private func notificationsTapped() {
        let alert = UIAlertController(title: "Notifications", message: "You're on a great streak! Keep learning to earn your next badge.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Quick Action View Component
final class QuickActionView: UIControl {
    
    init(iconName: String, iconColor: UIColor, title: String, subtitle: String) {
        super.init(frame: .zero)
        applyCardStyle(cornerRadius: 16)
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = iconColor
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = BrainRushTheme.textSecondary
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = BrainRushTheme.textSecondary
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        let row = UIStackView(arrangedSubviews: [icon, textStack, chevron])
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 16
        row.translatesAutoresizingMaskIntoConstraints = false
        row.isUserInteractionEnabled = false
        addSubview(row)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 72),
            row.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            row.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            row.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
