//
//  Constants.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import Foundation
import UIKit

struct Constants {
    private init() {}
    
    struct UI {
        private init() {}
        
        struct ImagesNames {
            private init() {}
            
            static let logo = "logo"
            static let logoWithText = "logo_with_text_vertical"
        }
        
        struct FontsNames {
            private init() {}
            
            static let general: String = "KohinoorDevanagari-Regular"
            static let medium: String = "KohinoorDevanagari-Medium"
            static let semibold: String = "KohinoorDevanagari-Semibold"
        }
        
        struct Colors {
            private init() {}
            
            static let primary: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let secondary: UIColor = #colorLiteral(red: 0.9698011279, green: 0.2449444234, blue: 0.1140630171, alpha: 1)
            static let shapes: UIColor = #colorLiteral(red: 0.1568627451, green: 0.1568627451, blue: 0.1568627451, alpha: 1)
        }
    }
    
    struct Network {
        private init() {}
        
        static let baseUrl = ""
        static let watchBaseUrl = ""
        
        static func urlToWatch(video id: String) -> String {
            return watchBaseUrl + id
        }
    }
}
