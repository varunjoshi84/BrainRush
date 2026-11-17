//
//  GameManager.swift
//  BrainRush
//

import Foundation
import UIKit

final class GameManager {
    
    static let shared = GameManager()
    
    // MARK: - Constants & Keys
    private let playerDefaultsKey = "BrainRush_PlayerData"
    private let isLoggedInKey = "BrainRush_IsLoggedIn"
    private let resultsHistoryKey = "BrainRush_ResultsHistory"
    
    // MARK: - App Color Scheme
    static let primaryPurple = UIColor(red: 64/255.0, green: 0/255.0, blue: 158/255.0, alpha: 1.0)
    static let lightPurpleBackground = UIColor(red: 246/255.0, green: 244/255.0, blue: 254/255.0, alpha: 1.0)
    static let accentGold = UIColor(red: 255/255.0, green: 179/255.0, blue: 0/255.0, alpha: 1.0)
    static let accentGreen = UIColor(red: 46/255.0, green: 184/255.0, blue: 92/255.0, alpha: 1.0)
    
    // MARK: - Master Badges Definition
    static let allMasterBadges: [Badge] = [
        Badge(
            id: "first_win",
            name: "First Win",
            unlockRequirement: "Answer the first question correctly",
            iconSystemName: "rosette",
            isEarned: false
        ),
        Badge(
            id: "streak_5",
            name: "5-Streak",
            unlockRequirement: "Get 5 correct answers in a row",
            iconSystemName: "flame.fill",
            isEarned: false
        ),
        Badge(
            id: "level_3",
            name: "Level 3 Reached",
            unlockRequirement: "Reach Level 3",
            iconSystemName: "star.fill",
            isEarned: false
        ),
        Badge(
            id: "perfect_round",
            name: "Perfect Round",
            unlockRequirement: "Answer every question in a round correctly",
            iconSystemName: "trophy.fill",
            isEarned: false
        )
    ]
    
    // MARK: - Active State
    private(set) var currentPlayer: Player
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: playerDefaultsKey),
           let saved = try? JSONDecoder().decode(Player.self, from: data) {
            self.currentPlayer = saved
        } else {
            // Default profile matching requirements & design
            self.currentPlayer = Player(
                name: "Varun Joshi",
                email: "varun@example.com",
                totalXP: 250, // Matches initial design (Level 3, 250 XP, 5 streak, 3 badges)
                currentStreak: 5,
                bestStreak: 5,
                unlockedBadgeIds: ["first_win", "streak_5", "level_3"]
            )
        }
    }
    
    // MARK: - Auth State
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isLoggedInKey)
        }
    }
    
    func login(name: String, email: String) {
        currentPlayer.name = name.isEmpty ? "Varun Joshi" : name
        currentPlayer.email = email
        isLoggedIn = true
        savePlayer()
    }
    
    func register(name: String, email: String) {
        currentPlayer = Player(
            name: name,
            email: email,
            totalXP: 0,
            currentStreak: 0,
            bestStreak: 0,
            unlockedBadgeIds: []
        )
        isLoggedIn = true
        savePlayer()
    }
    
    func logout() {
        isLoggedIn = false
    }
    
    func updateProfile(name: String, email: String) {
        currentPlayer.name = name
        currentPlayer.email = email
        savePlayer()
    }
    
    // MARK: - Save State
    func savePlayer() {
        if let data = try? JSONEncoder().encode(currentPlayer) {
            UserDefaults.standard.set(data, forKey: playerDefaultsKey)
        }
    }
    
    // MARK: - Quiz Progression & Rewards
    /// Calculates XP and streak for an individual answer
    func recordAnswer(isCorrect: Bool, baseReward: Int) -> (xpGained: Int, currentStreak: Int, bonusMessage: String?) {
        if isCorrect {
            currentPlayer.currentStreak += 1
            if currentPlayer.currentStreak > currentPlayer.bestStreak {
                currentPlayer.bestStreak = currentPlayer.currentStreak
            }
            
            var xpGained = baseReward
            var bonusMessage: String? = nil
            
            // Streak bonuses per specification:
            // 3 in a row: +10 XP
            // 5 in a row: +25 XP
            if currentPlayer.currentStreak == 3 {
                xpGained += 10
                bonusMessage = "+10 Streak Bonus!"
            } else if currentPlayer.currentStreak == 5 {
                xpGained += 25
                bonusMessage = "+25 Super Streak Bonus!"
            }
            
            currentPlayer.totalXP += xpGained
            checkAndUnlockBadges()
            savePlayer()
            return (xpGained, currentPlayer.currentStreak, bonusMessage)
        } else {
            // Wrong answer resets streak, never removes XP
            currentPlayer.currentStreak = 0
            savePlayer()
            return (0, 0, nil)
        }
    }
    
    /// Finalizes a quiz round and records result history
    func finalizeQuiz(topicTitle: String, score: Int, totalQuestions: Int, xpEarned: Int, bestStreakInRound: Int) -> QuizResult {
        let result = QuizResult(
            topicTitle: topicTitle,
            score: score,
            totalQuestions: totalQuestions,
            xpEarned: xpEarned,
            bestStreak: bestStreakInRound,
            date: Date()
        )
        
        // Check for Perfect Round badge
        if score == totalQuestions && totalQuestions > 0 {
            unlockBadge(id: "perfect_round")
        }
        
        checkAndUnlockBadges()
        savePlayer()
        
        // Save to quiz history
        var history = getQuizHistory()
        history.append(result)
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: resultsHistoryKey)
        }
        
        return result
    }
    
    func getQuizHistory() -> [QuizResult] {
        guard let data = UserDefaults.standard.data(forKey: resultsHistoryKey),
              let list = try? JSONDecoder().decode([QuizResult].self, from: data) else {
            return []
        }
        return list
    }
    
    // MARK: - Badges
    func getBadges() -> [Badge] {
        return GameManager.allMasterBadges.map { badge in
            var b = badge
            b.isEarned = currentPlayer.unlockedBadgeIds.contains(b.id)
            return b
        }
    }
    
    func checkAndUnlockBadges() {
        // First win badge
        if currentPlayer.totalXP > 0 {
            unlockBadge(id: "first_win")
        }
        // 5-streak badge
        if currentPlayer.bestStreak >= 5 {
            unlockBadge(id: "streak_5")
        }
        // Level 3 badge
        if currentPlayer.level >= 3 {
            unlockBadge(id: "level_3")
        }
    }
    
    private func unlockBadge(id: String) {
        if !currentPlayer.unlockedBadgeIds.contains(id) {
            currentPlayer.unlockedBadgeIds.append(id)
            savePlayer()
        }
    }
    
    // MARK: - Question Selection
    /// Filters questions matching the player's tier for the specified topic
    func getQuestions(forTopicId topicId: String) -> [Question] {
        let tier = currentPlayer.difficultyTier
        var matching = QuestionBank.allQuestions.filter { $0.topicId == topicId && $0.difficulty == tier }
        
        // If not enough questions in exact tier, fallback to any available for this topic
        if matching.count < 3 {
            matching = QuestionBank.allQuestions.filter { $0.topicId == topicId }
        }
        
        return Array(matching.shuffled().prefix(10))
    }
}
