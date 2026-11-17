//
//  AchievementsViewController.swift
//  BrainRush
//

import UIKit

final class AchievementsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var badges: [Badge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Achievements"
        navigationController?.setNavigationBarHidden(false, animated: animated)
        badges = GameManager.shared.getBadges()
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = BrainRushTheme.screenBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BadgeCell.self, forCellReuseIdentifier: BadgeCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 88
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return badges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BadgeCell.identifier, for: indexPath) as? BadgeCell else {
            return UITableViewCell()
        }
        let badge = badges[indexPath.row]
        cell.configure(with: badge)
        return cell
    }
}

// MARK: - Custom Badge Cell
final class BadgeCell: UITableViewCell {
    
    static let identifier = "BadgeCell"
    
    private let cardView = UIView()
    private let iconCircle = UIView()
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descLabel = UILabel()
    private let statusImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        cardView.applyCardStyle(cornerRadius: 16)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        
        iconCircle.layer.cornerRadius = 22
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(iconCircle)
        
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconCircle.addSubview(iconImageView)
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .black
        
        descLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descLabel.textColor = BrainRushTheme.textSecondary
        descLabel.numberOfLines = 2
        
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, descLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 3
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(labelStack)
        
        statusImageView.contentMode = .scaleAspectFit
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(statusImageView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            iconCircle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            iconCircle.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconCircle.widthAnchor.constraint(equalToConstant: 44),
            iconCircle.heightAnchor.constraint(equalToConstant: 44),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            labelStack.leadingAnchor.constraint(equalTo: iconCircle.trailingAnchor, constant: 14),
            labelStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            labelStack.trailingAnchor.constraint(lessThanOrEqualTo: statusImageView.leadingAnchor, constant: -12),
            
            statusImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            statusImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: 24),
            statusImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with badge: Badge) {
        nameLabel.text = badge.name
        descLabel.text = badge.unlockRequirement
        iconImageView.image = UIImage(systemName: badge.iconSystemName)
        
        if badge.isEarned {
            iconCircle.backgroundColor = BrainRushTheme.gold
            statusImageView.image = UIImage(systemName: "checkmark.circle.fill")
            statusImageView.tintColor = BrainRushTheme.successGreen
            nameLabel.textColor = .black
            cardView.alpha = 1.0
        } else {
            iconCircle.backgroundColor = UIColor.systemGray4
            statusImageView.image = UIImage(systemName: "lock.fill")
            statusImageView.tintColor = BrainRushTheme.textSecondary
            nameLabel.textColor = BrainRushTheme.textSecondary
            cardView.alpha = 0.75
        }
    }
}
