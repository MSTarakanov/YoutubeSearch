//
//  Extensions.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import Foundation
import UIKit

// MARK: UI extensions
extension UIFont {
    static func generalRegular(with size: CGFloat) -> UIFont {
        return UIFont(name: Constants.UI.FontsNames.general, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func generalMedium(with size: CGFloat) -> UIFont {
        return UIFont(name: Constants.UI.FontsNames.medium, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func generalSemibold(with size: CGFloat) -> UIFont {
        return UIFont(name: Constants.UI.FontsNames.semibold, size: size) ?? .systemFont(ofSize: size)
    }
}

// MARK: Format extensions

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

// MARK: Alert extensions
extension UIViewController {

    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
