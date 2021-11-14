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
    // MARK: UI constants -
    struct UI {
        private init() {}
        
        struct ImagesNames {
            private init() {}
            
            static let likeImage = "like"
            static let dislikeImage = "dislike"
            static let logo = "logo"
            static let logoWithTextVertical = "logo_with_text_vertical"
            static let logoWithTextHorizontal = "logo_with_text_horizontal"
            static let profilePlaceholder = "profile_placeholder"
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
            static let secondaryShapes: UIColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6)
        }
    }
    // MARK: Network constants -
    struct Network {
        private init() {}
        
        static let baseYoutubeUrl = "https://youtube.googleapis.com/youtube/v3/"
        static let yotubeSearchUrl = baseYoutubeUrl + "search"
        static let yotubeVideoDetailsUrl = baseYoutubeUrl + "videos"
        static let yotubeChannelDetailsUrl = baseYoutubeUrl + "channels"
        static let watchUrl = "https://www.youtube.com/watch?v="
        
        static func urlToWatch(video id: String) -> String {
            return watchUrl + id
        }
    }
}
