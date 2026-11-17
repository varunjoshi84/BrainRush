//
//  TopicDetailViewController.swift
//  BrainRush
//

import UIKit

final class TopicDetailViewController: UIViewController {

    private let topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "Topic Details"
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
        
        // Large Topic Icon Container
        let iconCard = UIView()
        iconCard.backgroundColor = BrainRushTheme.lightPurpleTint
        iconCard.layer.cornerRadius = 24
        iconCard.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(iconCard)
        
        let iconView = UIImageView(image: UIImage(systemName: topic.iconSystemName))
        iconView.tintColor = BrainRushTheme.primaryPurple
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconCard.addSubview(iconView)
        
        // Title
        let titleLabel = UILabel()
        titleLabel.text = topic.title
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(titleLabel)
        
        // Description
        let descLabel = UILabel()
        descLabel.text = topic.details
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descLabel.textColor = BrainRushTheme.textSecondary
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(descLabel)
        
        // Info Metadata Card
        let infoCard = UIView()
        infoCard.applyCardStyle(cornerRadius: 18)
        infoCard.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(infoCard)
        
        let currentTier = GameManager.shared.currentPlayer.difficultyTier
        
        let questionsRow = makeInfoRow(title: "Questions", value: "10")
        let difficultyRow = makeInfoRow(title: "Difficulty (Your Level)", value: currentTier.title, valueColor: BrainRushTheme.primaryPurple)
        let xpRow = makeInfoRow(title: "XP per Correct", value: "\(currentTier.xpPerCorrect)")
        
        let divider1 = makeDivider()
        let divider2 = makeDivider()
        
        let infoStack = UIStackView(arrangedSubviews: [questionsRow, divider1, difficultyRow, divider2, xpRow])
        infoStack.axis = .vertical
        infoStack.spacing = 14
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoCard.addSubview(infoStack)
        
        // Start Quiz Button
        let startButton = UIButton(type: .system)
        startButton.applyPrimaryButtonStyle(title: "▶  Start Quiz")
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startQuizTapped), for: .touchUpInside)
        content.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            iconCard.topAnchor.constraint(equalTo: content.topAnchor, constant: 30),
            iconCard.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            iconCard.widthAnchor.constraint(equalToConstant: 100),
            iconCard.heightAnchor.constraint(equalToConstant: 100),
            
            iconView.centerXAnchor.constraint(equalTo: iconCard.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconCard.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 50),
            iconView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: iconCard.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -24),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 24),
            descLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -24),
            
            infoCard.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 28),
            infoCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            infoCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            
            infoStack.topAnchor.constraint(equalTo: infoCard.topAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -16),
            infoStack.bottomAnchor.constraint(equalTo: infoCard.bottomAnchor, constant: -16),
            
            startButton.topAnchor.constraint(equalTo: infoCard.bottomAnchor, constant: 36),
            startButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 54),
            startButton.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -40)
        ])
    }
    
    private func makeInfoRow(title: String, value: String, valueColor: UIColor = .black) -> UIStackView {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLbl.textColor = BrainRushTheme.textSecondary
        
        let valLbl = UILabel()
        valLbl.text = value
        valLbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        valLbl.textColor = valueColor
        valLbl.textAlignment = .right
        
        let row = UIStackView(arrangedSubviews: [titleLbl, valLbl])
        row.axis = .horizontal
        row.distribution = .equalSpacing
        return row
    }
    
    private func makeDivider() -> UIView {
        let v = UIView()
        v.backgroundColor = BrainRushTheme.subtleGray
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return v
    }
    
    @objc private func startQuizTapped() {
        let questions = GameManager.shared.getQuestions(forTopicId: topic.id)
        let quizVC = QuizViewController(topic: topic, questions: questions)
        quizVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(quizVC, animated: true)
    }
}
