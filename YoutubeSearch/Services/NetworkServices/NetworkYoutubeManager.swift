//
//  NetworkYoutubeManager.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import Foundation

protocol NetworkYoutubeManagerProtocol {
    func getVideos(with query: String, completion: @escaping (Result<[Video]?, NetworkError>) -> Void)
}

// https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=surfing&key=AIzaSyANZhJ-amES3tz3iMFcuDPbuH1YjtkLYqQ
class NetworkYoutubeManager: NetworkYoutubeManagerProtocol {
    
    private func getRequest(with query: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: Constants.Network.baseYotubeSearchUrl) else {
            print("[DEBUG] baseYotubeSearchUrl goes wrong!")
            return nil
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "maxResults", value: "\(25)"),
            URLQueryItem(name: "q", value: query.lowercased()),
            URLQueryItem(name: "key", value: Credentials.apiKey),
        ]
        guard let url = urlComponents.url else {
            print("[DEBUG] fullYotubeSearchUrl goes wrong!")
            return nil
        }
        return URLRequest(url: url)
    }
    
    func getVideos(with query: String, completion: @escaping (Result<[Video]?, NetworkError>) -> Void) {
        guard let request = getRequest(with: query) else {
            print("[DEBUG] search request failed")
            completion(.failure(.invalidRequest))
            return
        }
        
        
    }
}

enum NetworkError: String, Error {
    case invalidRequest = "Sorry. You did invalid request"
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(rawValue, comment: "")
    }
}
