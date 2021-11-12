//
//  ImageLoader.swift
//  YoutubeSearch
//
//  Created by Максим Тараканов on 13.11.2021.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from path: String) -> UIImage?
}

class ImageLoader: ImageLoaderProtocol {
    func loadImage(from path: String) -> UIImage? {
        guard let url = URL(string: path) else {
            print("[DEBUG] Bad url: \(path)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else {
                print("[DEBUG] no image from data with path: \(path)")
                return nil
            }
            return image
        } catch {
            print("[DEBUG] Error with data from \(path) with error: \(error.localizedDescription)")
            return nil
        }
        
        
    }
}

//protocol ImageLoaderProtocol {
//    func loadImage(from path: String, completion: @escaping (UIImage?) -> ())
//}
//
//class ImageLoader: ImageLoaderProtocol {
//    func loadImage(from path: String, completion: @escaping (UIImage?) -> ()) {
//        guard let url = URL(string: path) else {
//            print("[DEBUG] Bad path for URL: \(path)")
//            completion(nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("[DEBUG] error in dataTask: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                switch response.statusCode {
//                case 200..<300: break
//                default:
//                    print("[DEBUG] Bad response. Status code: \(response.statusCode)")
//                }
//            }
//
//            if let data = data {
//                if let image = UIImage(data: data) {
//                    completion(image)
//                } else {
//                    print("[DEBUG] Bad data by path: \(path)")
//                    completion(nil)
//                    return
//                }
//            }
//        }
//        task.resume()
//    }
//}
