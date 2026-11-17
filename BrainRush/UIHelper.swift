//
//  UIHelper.swift
//  BrainRush
//

import UIKit

enum BrainRushTheme {
    static let primaryPurple = UIColor(red: 64/255.0, green: 0/255.0, blue: 158/255.0, alpha: 1.0) // #40009E
    static let accentPurple = UIColor(red: 98/255.0, green: 35/255.0, blue: 204/255.0, alpha: 1.0)
    static let cardBackground = UIColor.white
    static let screenBackground = UIColor(red: 247/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
    static let gold = UIColor(red: 255/255.0, green: 184/255.0, blue: 0/255.0, alpha: 1.0)
    static let flameOrange = UIColor(red: 255/255.0, green: 107/255.0, blue: 0/255.0, alpha: 1.0)
    static let successGreen = UIColor(red: 46/255.0, green: 184/255.0, blue: 92/255.0, alpha: 1.0)
    static let subtleGray = UIColor(red: 240/255.0, green: 240/255.0, blue: 245/255.0, alpha: 1.0)
    static let textSecondary = UIColor(red: 120/255.0, green: 120/255.0, blue: 130/255.0, alpha: 1.0)
    static let lightPurpleTint = UIColor(red: 236/255.0, green: 230/255.0, blue: 252/255.0, alpha: 1.0)
}

extension UIView {
    func applyCardStyle(cornerRadius: CGFloat = 16, shadowOpacity: Float = 0.08) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8
        self.backgroundColor = BrainRushTheme.cardBackground
    }
    
    func applyPrimaryButtonStyle(title: String, cornerRadius: CGFloat = 14) {
        if let btn = self as? UIButton {
            btn.backgroundColor = BrainRushTheme.primaryPurple
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            btn.layer.cornerRadius = cornerRadius
            btn.layer.masksToBounds = true
        }
    }
}
