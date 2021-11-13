//
//  NetworkYoutubeManager.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 11.11.2021.
//

import Foundation

protocol NetworkYoutubeManagerProtocol {
    func getVideos(with query: String, completion: @escaping (Result<SearchResponseModel?, NetworkError>) -> Void)
    func getVideoDetails(by videoID: String, completion: @escaping (Result<VideoResponseModel?, NetworkError>) -> Void)
    func getChannelDetails(by channelID: String, completion: @escaping (Result<ChannelResponseModel?, NetworkError>) -> Void)
}

// https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=surfing&key=AIzaSyANZhJ-amES3tz3iMFcuDPbuH1YjtkLYqQ
final class NetworkYoutubeManager: NetworkYoutubeManagerProtocol {
    
    // MARK: Private helpers -
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
    
    // MARK: Requests -
    func getVideos(with query: String, completion: @escaping (Result<SearchResponseModel?, NetworkError>) -> Void) {
        guard let request = getRequest(with: query) else {
            print("[DEBUG] search request failed")
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[DEBUG] error in dataTask: \(error.localizedDescription)")
                completion(.failure(.dataTaskError))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300: break
                default:
                    print("[DEBUG] Bad response. Status code: \(response.statusCode)")
                }
            }
            
            if let data = data {
                do {
                    let searchResponseModel = try JSONDecoder().decode(SearchResponseModel.self, from: data)
                    completion(.success(searchResponseModel))
                } catch {
                    print("[DEBUG] Bad data with error: \(error.localizedDescription)")
                    completion(.failure(.badDataReceived))
                    return
                }
            }
        }
        task.resume()
    }
    
    func getVideoDetails(by videoID: String, completion: @escaping (Result<VideoResponseModel?, NetworkError>) -> Void) {
        
    }
    
    func getChannelDetails(by channelID: String, completion: @escaping (Result<ChannelResponseModel?, NetworkError>) -> Void) {
        
    }
}

// MARK: Error Handling -

enum NetworkError: String, Error {
    case invalidRequest = "Sorry. You did invalid request"
    case dataTaskError = "Oops. Try again"
    case badDataReceived = "Bad data received"
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(rawValue, comment: "")
    }
}
