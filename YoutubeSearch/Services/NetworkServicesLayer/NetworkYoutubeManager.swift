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

final class NetworkYoutubeManager: NetworkYoutubeManagerProtocol {
    
    // MARK: Private helpers -
    private func getSearchRequest(with query: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: Constants.Network.yotubeSearchUrl) else {
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
    
// https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=Ks-_Mh1QhMc&key=[YOUR_API_KEY]
    private func getVideoDetailsRequest(with videoID: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: Constants.Network.yotubeVideoDetailsUrl) else {
            print("[DEBUG] yotubeVideoDetailsUrl goes wrong!")
            return nil
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "part", value: "snippet,contentDetails,statistics"),
            URLQueryItem(name: "id", value: "\(videoID)"),
            URLQueryItem(name: "key", value: Credentials.apiKey),
        ]
        guard let url = urlComponents.url else {
            print("[DEBUG] fullYotubeVideoDetailsUrl goes wrong!")
            return nil
        }
        return URLRequest(url: url)
    }
// https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UC_x5XG1OV2P6uZZ5FSM9Ttw&key=[YOUR_API_KEY]
    private func getChannelDetailsRequest(with channelID: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: Constants.Network.yotubeChannelDetailsUrl) else {
            print("[DEBUG] yotubeChannelDetailsUrl goes wrong!")
            return nil
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "part", value: "snippet,contentDetails,statistics"),
            URLQueryItem(name: "id", value: "\(channelID)"),
            URLQueryItem(name: "key", value: Credentials.apiKey),
        ]
        guard let url = urlComponents.url else {
            print("[DEBUG] fullYotubeVideoDetailsUrl goes wrong!")
            return nil
        }
        return URLRequest(url: url)
    }
    
    // MARK: Requests -
    // TODO: change to generic with request -
    func getVideos(with query: String, completion: @escaping (Result<SearchResponseModel?, NetworkError>) -> Void) {
        guard let request = getSearchRequest(with: query) else {
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
                    print("[DEBUG] Bad data from \(String(describing: request.url?.description)) with error: \(error.localizedDescription)")
                    completion(.failure(.badDataReceived))
                    return
                }
            }
        }
        task.resume()
    }
    
    func getVideoDetails(by videoID: String, completion: @escaping (Result<VideoResponseModel?, NetworkError>) -> Void) {
        guard let request = getVideoDetailsRequest(with: videoID) else {
            print("[DEBUG] videoDetails request failed")
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
                    let videoResponseModel = try JSONDecoder().decode(VideoResponseModel.self, from: data)
                    completion(.success(videoResponseModel))
                } catch {
                    print("[DEBUG] Bad data from \(String(describing: request.url?.description)) with error: \(error.localizedDescription)")
                    completion(.failure(.badDataReceived))
                    return
                }
            }
        }
        task.resume()
    }
    
    func getChannelDetails(by channelID: String, completion: @escaping (Result<ChannelResponseModel?, NetworkError>) -> Void) {
        guard let request = getChannelDetailsRequest(with: channelID) else {
            print("[DEBUG] channelDetails request failed")
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
                    let channelResponseModel = try JSONDecoder().decode(ChannelResponseModel.self, from: data)
                    completion(.success(channelResponseModel))
                } catch {
                    print("[DEBUG] Bad data from \(String(describing: request.url?.description)) with error: \(error.localizedDescription)")
                    completion(.failure(.badDataReceived))
                    return
                }
            }
        }
        task.resume()
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
