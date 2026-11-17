//
//  QuizViewController.swift
//  BrainRush
//

import UIKit

final class QuizViewController: UIViewController {

    private let topic: Topic
    private let questions: [Question]
    private var currentIndex: Int = 0
    private var score: Int = 0
    private var xpEarnedThisRound: Int = 0
    private var bestStreakThisRound: Int = 0
    private var currentStreakThisRound: Int = 0
    
    // UI Elements
    private let headerCard = UIView()
    private let questionCounterLabel = UILabel()
    private let streakPill = UIView()
    private let streakLabel = UILabel()
    private let xpPill = UIView()
    private let xpLabel = UILabel()
    
    private let questionCard = UIView()
    private let questionTextLabel = UILabel()
    
    private var optionButtons: [UIButton] = []
    private let optionsStack = UIStackView()
    private let nextButton = UIButton(type: .system)
    
    private var selectedOptionIndex: Int? = nil
    
    init(topic: Topic, questions: [Question]) {
        self.topic = topic
        self.questions = questions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Quiz"
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = BrainRushTheme.screenBackground
        
        // Header Status Bar (Q. 3/10 | Streak: 3 🔥 | XP: 60)
        headerCard.backgroundColor = .clear
        headerCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerCard)
        
        questionCounterLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        questionCounterLabel.textColor = .black
        
        // Streak Pill
        streakPill.backgroundColor = UIColor(red: 255/255.0, green: 243/255.0, blue: 235/255.0, alpha: 1.0)
        streakPill.layer.cornerRadius = 12
        streakLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        streakLabel.textColor = BrainRushTheme.flameOrange
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        streakPill.addSubview(streakLabel)
        
        NSLayoutConstraint.activate([
            streakLabel.leadingAnchor.constraint(equalTo: streakPill.leadingAnchor, constant: 10),
            streakLabel.trailingAnchor.constraint(equalTo: streakPill.trailingAnchor, constant: -10),
            streakLabel.topAnchor.constraint(equalTo: streakPill.topAnchor, constant: 4),
            streakLabel.bottomAnchor.constraint(equalTo: streakPill.bottomAnchor, constant: -4)
        ])
        
        // XP Pill
        xpPill.backgroundColor = BrainRushTheme.lightPurpleTint
        xpPill.layer.cornerRadius = 12
        xpLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        xpLabel.textColor = BrainRushTheme.primaryPurple
        xpLabel.translatesAutoresizingMaskIntoConstraints = false
        xpPill.addSubview(xpLabel)
        
        NSLayoutConstraint.activate([
            xpLabel.leadingAnchor.constraint(equalTo: xpPill.leadingAnchor, constant: 10),
            xpLabel.trailingAnchor.constraint(equalTo: xpPill.trailingAnchor, constant: -10),
            xpLabel.topAnchor.constraint(equalTo: xpPill.topAnchor, constant: 4),
            xpLabel.bottomAnchor.constraint(equalTo: xpPill.bottomAnchor, constant: -4)
        ])
        
        let headerStack = UIStackView(arrangedSubviews: [questionCounterLabel, streakPill, xpPill])
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerCard.addSubview(headerStack)
        
        // Question Card
        questionCard.applyCardStyle(cornerRadius: 18)
        questionCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionCard)
        
        questionTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        questionTextLabel.textColor = .black
        questionTextLabel.numberOfLines = 0
        questionTextLabel.textAlignment = .left
        questionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        questionCard.addSubview(questionTextLabel)
        
        // Options Stack
        optionsStack.axis = .vertical
        optionsStack.spacing = 14
        optionsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionsStack)
        
        // Next Button
        nextButton.applyPrimaryButtonStyle(title: "Next")
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            headerCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            headerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerCard.heightAnchor.constraint(equalToConstant: 40),
            
            headerStack.leadingAnchor.constraint(equalTo: headerCard.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: headerCard.trailingAnchor),
            headerStack.centerYAnchor.constraint(equalTo: headerCard.centerYAnchor),
            
            questionCard.topAnchor.constraint(equalTo: headerCard.bottomAnchor, constant: 14),
            questionCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            questionTextLabel.topAnchor.constraint(equalTo: questionCard.topAnchor, constant: 20),
            questionTextLabel.leadingAnchor.constraint(equalTo: questionCard.leadingAnchor, constant: 18),
            questionTextLabel.trailingAnchor.constraint(equalTo: questionCard.trailingAnchor, constant: -18),
            questionTextLabel.bottomAnchor.constraint(equalTo: questionCard.bottomAnchor, constant: -20),
            
            optionsStack.topAnchor.constraint(equalTo: questionCard.bottomAnchor, constant: 20),
            optionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func loadQuestion() {
        guard currentIndex < questions.count else {
            finishQuiz()
            return
        }
        
        let q = questions[currentIndex]
        selectedOptionIndex = nil
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        
        questionCounterLabel.text = "Q. \(currentIndex + 1) / \(questions.count)"
        streakLabel.text = "Streak: \(currentStreakThisRound) 🔥"
        xpLabel.text = "XP: \(xpEarnedThisRound)"
        questionTextLabel.text = q.text
        
        // Rebuild option buttons
        optionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        optionButtons.removeAll()
        
        let prefixes = ["A", "B", "C", "D"]
        for (i, opt) in q.options.enumerated() {
            let prefix = i < prefixes.count ? prefixes[i] : "\(i + 1)"
            let btn = createOptionButton(prefix: prefix, text: opt, tag: i)
            optionButtons.append(btn)
            optionsStack.addArrangedSubview(btn)
        }
    }
    
    private func createOptionButton(prefix: String, text: String, tag: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.tag = tag
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = BrainRushTheme.subtleGray.cgColor
        btn.backgroundColor = .white
        btn.contentHorizontalAlignment = .leading
        
        var config = UIButton.Configuration.plain()
        config.title = "  \(prefix).  \(text)"
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        btn.configuration = config
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(greaterThanOrEqualToConstant: 52).isActive = true
        btn.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        return btn
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        guard selectedOptionIndex == nil else { return } // Prevent double answer
        
        let chosenIndex = sender.tag
        selectedOptionIndex = chosenIndex
        
        // Disable option buttons to prevent multiple clicks
        optionButtons.forEach { $0.isUserInteractionEnabled = false }
        
        let q = questions[currentIndex]
        let isCorrect = (chosenIndex == q.correctOptionIndex)
        
        if isCorrect {
            sender.backgroundColor = BrainRushTheme.lightPurpleTint
            sender.layer.borderColor = BrainRushTheme.primaryPurple.cgColor
            
            score += 1
            currentStreakThisRound += 1
            if currentStreakThisRound > bestStreakThisRound {
                bestStreakThisRound = currentStreakThisRound
            }
            
            let rewardInfo = GameManager.shared.recordAnswer(isCorrect: true, baseReward: q.xpReward)
            xpEarnedThisRound += rewardInfo.xpGained
            
            showFeedbackModal(isCorrect: true, xpEarned: rewardInfo.xpGained, streak: currentStreakThisRound)
        } else {
            sender.backgroundColor = UIColor(red: 255/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
            sender.layer.borderColor = UIColor.systemRed.cgColor
            
            // Highlight the correct option
            if q.correctOptionIndex < optionButtons.count {
                let correctBtn = optionButtons[q.correctOptionIndex]
                correctBtn.layer.borderColor = BrainRushTheme.successGreen.cgColor
                correctBtn.backgroundColor = UIColor(red: 235/255.0, green: 250/255.0, blue: 240/255.0, alpha: 1.0)
            }
            
            currentStreakThisRound = 0
            _ = GameManager.shared.recordAnswer(isCorrect: false, baseReward: 0)
            
            showFeedbackModal(isCorrect: false, xpEarned: 0, streak: 0)
        }
        
        streakLabel.text = "Streak: \(currentStreakThisRound) 🔥"
        xpLabel.text = "XP: \(xpEarnedThisRound)"
        
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
    }
    
    private func showFeedbackModal(isCorrect: Bool, xpEarned: Int, streak: Int) {
        let modal = FeedbackModalViewController(isCorrect: isCorrect, xpEarned: xpEarned, streak: streak) { [weak self] in
            self?.proceedToNextQuestion()
        }
        modal.modalPresentationStyle = .overFullScreen
        modal.modalTransitionStyle = .crossDissolve
        present(modal, animated: true)
    }
    
    @objc private func nextTapped() {
        proceedToNextQuestion()
    }
    
    private func proceedToNextQuestion() {
        currentIndex += 1
        loadQuestion()
    }
    
    private func finishQuiz() {
        let result = GameManager.shared.finalizeQuiz(
            topicTitle: topic.title,
            score: score,
            totalQuestions: questions.count,
            xpEarned: xpEarnedThisRound,
            bestStreakInRound: bestStreakThisRound
        )
        
        let resultsVC = ResultsViewController(result: result) { [weak self] in
            // Play again callback
            self?.restartQuiz()
        }
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    private func restartQuiz() {
        currentIndex = 0
        score = 0
        xpEarnedThisRound = 0
        bestStreakThisRound = 0
        currentStreakThisRound = 0
        loadQuestion()
    }
}

// MARK: - Feedback Popup Modal
final class FeedbackModalViewController: UIViewController {
    
    private let isCorrect: Bool
    private let xpEarned: Int
    private let streak: Int
    private let onContinue: () -> Void
    
    init(isCorrect: Bool, xpEarned: Int, streak: Int, onContinue: @escaping () -> Void) {
        self.isCorrect = isCorrect
        self.xpEarned = xpEarned
        self.streak = streak
        self.onContinue = onContinue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 24
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        
        let iconCircle = UIView()
        iconCircle.backgroundColor = isCorrect ? BrainRushTheme.successGreen : UIColor.systemRed
        iconCircle.layer.cornerRadius = 28
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(iconCircle)
        
        let icon = UIImageView(image: UIImage(systemName: isCorrect ? "checkmark" : "xmark"))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        iconCircle.addSubview(icon)
        
        let statusLabel = UILabel()
        statusLabel.text = isCorrect ? "Correct!" : "Oops, Incorrect!"
        statusLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        statusLabel.textColor = .black
        statusLabel.textAlignment = .center
        
        let xpLabel = UILabel()
        xpLabel.text = isCorrect ? "+\(xpEarned) XP" : "+0 XP"
        xpLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        xpLabel.textColor = isCorrect ? BrainRushTheme.successGreen : BrainRushTheme.textSecondary
        xpLabel.textAlignment = .center
        
        let streakLabel = UILabel()
        streakLabel.text = "Streak: \(streak) 🔥"
        streakLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        streakLabel.textColor = BrainRushTheme.flameOrange
        streakLabel.textAlignment = .center
        
        let continueBtn = UIButton(type: .system)
        continueBtn.applyPrimaryButtonStyle(title: "Continue")
        continueBtn.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [statusLabel, xpLabel, streakLabel, continueBtn])
        stack.axis = .vertical
        stack.spacing = 14
        stack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stack)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            card.widthAnchor.constraint(equalToConstant: 290),
            
            iconCircle.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            iconCircle.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            iconCircle.widthAnchor.constraint(equalToConstant: 56),
            iconCircle.heightAnchor.constraint(equalToConstant: 56),
            
            icon.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 26),
            icon.heightAnchor.constraint(equalToConstant: 26),
            
            stack.topAnchor.constraint(equalTo: iconCircle.bottomAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24),
            
            continueBtn.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func continueTapped() {
        dismiss(animated: true) { [weak self] in
            self?.onContinue()
        }
    }
}
