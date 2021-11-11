//
//  Extensions.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import Foundation
import UIKit

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
