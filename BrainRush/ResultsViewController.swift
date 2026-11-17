//
//  ResultsViewController.swift
//  BrainRush
//

import UIKit

final class ResultsViewController: UIViewController {

    private let result: QuizResult
    private let onPlayAgain: () -> Void
    
    init(result: QuizResult, onPlayAgain: @escaping () -> Void) {
        self.result = result
        self.onPlayAgain = onPlayAgain
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
        navigationItem.title = "Results"
        navigationItem.hidesBackButton = true
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
        
        // Trophy Icon
        let trophyImageView = UIImageView(image: UIImage(systemName: "trophy.fill"))
        trophyImageView.tintColor = BrainRushTheme.gold
        trophyImageView.contentMode = .scaleAspectFit
        trophyImageView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(trophyImageView)
        
        // Title
        let titleLabel = UILabel()
        titleLabel.text = "Quiz Completed!"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(titleLabel)
        
        // Stats Card
        let statsCard = UIView()
        statsCard.applyCardStyle(cornerRadius: 18)
        statsCard.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(statsCard)
        
        let scoreRow = makeResultRow(title: "Score", value: "\(result.score) / \(result.totalQuestions)")
        let percentageRow = makeResultRow(title: "Percentage", value: "\(result.percentage) %")
        let xpRow = makeResultRow(title: "XP Earned", value: "+\(result.xpEarned) XP", valueColor: BrainRushTheme.successGreen)
        let streakRow = makeResultRow(title: "Best Streak", value: "\(result.bestStreak)")
        
        let statsStack = UIStackView(arrangedSubviews: [
            scoreRow,
            makeDivider(),
            percentageRow,
            makeDivider(),
            xpRow,
            makeDivider(),
            streakRow
        ])
        statsStack.axis = .vertical
        statsStack.spacing = 14
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        statsCard.addSubview(statsStack)
        
        // Feedback Banner
        let feedbackBanner = UIView()
        feedbackBanner.backgroundColor = UIColor(red: 232/255.0, green: 247/255.0, blue: 238/255.0, alpha: 1.0)
        feedbackBanner.layer.cornerRadius = 14
        feedbackBanner.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(feedbackBanner)
        
        let checkIcon = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        checkIcon.tintColor = BrainRushTheme.successGreen
        checkIcon.contentMode = .scaleAspectFit
        
        let feedbackText = UILabel()
        feedbackText.text = result.percentage >= 80 ? "Great Job!" : (result.percentage >= 50 ? "Good Effort!" : "Keep Practicing!")
        feedbackText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        feedbackText.textColor = BrainRushTheme.successGreen
        
        let feedbackStack = UIStackView(arrangedSubviews: [checkIcon, feedbackText])
        feedbackStack.axis = .horizontal
        feedbackStack.alignment = .center
        feedbackStack.spacing = 8
        feedbackStack.translatesAutoresizingMaskIntoConstraints = false
        feedbackBanner.addSubview(feedbackStack)
        
        // Action Buttons
        let backButton = UIButton(type: .system)
        backButton.applyPrimaryButtonStyle(title: "Back to Topics")
        backButton.addTarget(self, action: #selector(backToTopicsTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(backButton)
        
        let playAgainButton = UIButton(type: .system)
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.setTitleColor(BrainRushTheme.primaryPurple, for: .normal)
        playAgainButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        playAgainButton.backgroundColor = .white
        playAgainButton.layer.cornerRadius = 14
        playAgainButton.layer.borderWidth = 1.5
        playAgainButton.layer.borderColor = BrainRushTheme.primaryPurple.cgColor
        playAgainButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(playAgainButton)
        
        NSLayoutConstraint.activate([
            trophyImageView.topAnchor.constraint(equalTo: content.topAnchor, constant: 28),
            trophyImageView.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            trophyImageView.widthAnchor.constraint(equalToConstant: 72),
            trophyImageView.heightAnchor.constraint(equalToConstant: 72),
            
            titleLabel.topAnchor.constraint(equalTo: trophyImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            
            statsCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            statsCard.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            statsCard.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            
            statsStack.topAnchor.constraint(equalTo: statsCard.topAnchor, constant: 18),
            statsStack.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor, constant: 16),
            statsStack.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor, constant: -16),
            statsStack.bottomAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: -18),
            
            feedbackBanner.topAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: 24),
            feedbackBanner.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            feedbackBanner.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            feedbackBanner.heightAnchor.constraint(equalToConstant: 48),
            
            feedbackStack.centerXAnchor.constraint(equalTo: feedbackBanner.centerXAnchor),
            feedbackStack.centerYAnchor.constraint(equalTo: feedbackBanner.centerYAnchor),
            checkIcon.widthAnchor.constraint(equalToConstant: 22),
            checkIcon.heightAnchor.constraint(equalToConstant: 22),
            
            backButton.topAnchor.constraint(equalTo: feedbackBanner.bottomAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 52),
            
            playAgainButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 14),
            playAgainButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            playAgainButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            playAgainButton.heightAnchor.constraint(equalToConstant: 52),
            playAgainButton.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -34)
        ])
    }
    
    private func makeResultRow(title: String, value: String, valueColor: UIColor = .black) -> UIStackView {
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
    
    @objc private func backToTopicsTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func playAgainTapped() {
        navigationController?.popViewController(animated: false)
        onPlayAgain()
    }
}
