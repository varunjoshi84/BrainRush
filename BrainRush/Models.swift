//
//  Models.swift
//  BrainRush
//

import Foundation

// MARK: - Difficulty Tier
enum DifficultyTier: Int, Codable, CaseIterable {
    case rookie = 1      // Levels 1-2, Easy
    case challenger = 2  // Levels 3-4, Medium
    case pro = 3         // Levels 5-6, Hard
    case legend = 4      // Levels 7+, Very Hard
    
    var title: String {
        switch self {
        case .rookie: return "Easy"
        case .challenger: return "Medium"
        case .pro: return "Hard"
        case .legend: return "Very Hard"
        }
    }
    
    var tierName: String {
        switch self {
        case .rookie: return "Rookie"
        case .challenger: return "Challenger"
        case .pro: return "Pro"
        case .legend: return "Legend"
        }
    }
    
    var xpPerCorrect: Int {
        switch self {
        case .rookie: return 10
        case .challenger: return 20
        case .pro: return 30
        case .legend: return 50
        }
    }
    
    static func tier(forLevel level: Int) -> DifficultyTier {
        switch level {
        case 1...2:
            return .rookie
        case 3...4:
            return .challenger
        case 5...6:
            return .pro
        default:
            return .legend
        }
    }
}

// MARK: - Question Model
struct Question: Identifiable, Codable {
    let id: String
    let topicId: String
    let text: String
    let options: [String]
    let correctOptionIndex: Int
    let difficulty: DifficultyTier
    let xpReward: Int
    
    init(id: String = UUID().uuidString,
         topicId: String,
         text: String,
         options: [String],
         correctOptionIndex: Int,
         difficulty: DifficultyTier) {
        self.id = id
        self.topicId = topicId
        self.text = text
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self.difficulty = difficulty
        self.xpReward = difficulty.xpPerCorrect
    }
}

// MARK: - Topic Model
struct Topic: Identifiable, Codable {
    let id: String
    let title: String
    let summary: String
    let iconSystemName: String
    let details: String
    var isCompleted: Bool = false
}

// MARK: - Badge Model
struct Badge: Identifiable, Codable {
    let id: String
    let name: String
    let unlockRequirement: String
    let iconSystemName: String
    var isEarned: Bool
}

// MARK: - Quiz Result Model
struct QuizResult: Codable {
    let topicTitle: String
    let score: Int
    let totalQuestions: Int
    let xpEarned: Int
    let bestStreak: Int
    let date: Date
    
    var percentage: Int {
        guard totalQuestions > 0 else { return 0 }
        return Int((Double(score) / Double(totalQuestions)) * 100.0)
    }
}

// MARK: - Player Profile Model
struct Player: Codable {
    var name: String
    var email: String
    var totalXP: Int
    var currentStreak: Int
    var bestStreak: Int
    var unlockedBadgeIds: [String]
    
    // Level calculated from totalXP according to requirements:
    // L1: 0, L2: 100, L3: 250, L4: 450, L5: 700, L6: 1000, L7: 1400
    var level: Int {
        switch totalXP {
        case 0..<100: return 1
        case 100..<250: return 2
        case 250..<450: return 3
        case 450..<700: return 4
        case 700..<1000: return 5
        case 1000..<1400: return 6
        default:
            return 7 + max(0, (totalXP - 1400) / 500)
        }
    }
    
    var nextLevelXP: Int {
        switch level {
        case 1: return 100
        case 2: return 250
        case 3: return 450
        case 4: return 700
        case 5: return 1000
        case 6: return 1400
        default: return 1400 + (level - 6) * 500
        }
    }
    
    var currentLevelBaseXP: Int {
        switch level {
        case 1: return 0
        case 2: return 100
        case 3: return 250
        case 4: return 450
        case 5: return 700
        case 6: return 1000
        default: return 1400 + (level - 7) * 500
        }
    }
    
    var levelProgressFraction: Float {
        let base = Float(currentLevelBaseXP)
        let target = Float(nextLevelXP)
        let current = Float(totalXP)
        guard target > base else { return 1.0 }
        return max(0.0, min(1.0, (current - base) / (target - base)))
    }
    
    var difficultyTier: DifficultyTier {
        return DifficultyTier.tier(forLevel: level)
    }
}
