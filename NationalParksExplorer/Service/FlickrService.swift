//
//  FlickrService.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation
import UIKit

enum FlickrServiceError: Error {
    case RequestFailed
    case CouldNotParseResponse
    case ImageDownloadFailed
}

class FlickrService {
    
    // secret: 6d46272c25778e63
    let apiKey = "cfb0edabee51802cdb456494f3b0d982"
    
    func searchPhotos(query: String, completion: @escaping ([FlickrPhotoData]?, Error?) -> Void) {
        
        let url = buildSearchURL(query: query)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let results = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(FlickrResponse.self, from: results)
                    completion(results.photos.photo, nil)
                } catch {
                    print(error)
                    completion(nil, FlickrServiceError.CouldNotParseResponse)
                }
            } else {
                print(error)
                completion(nil, FlickrServiceError.RequestFailed)
            }
        }
        
        task.resume()
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            } else {
                print(error)
                completion(nil, FlickrServiceError.ImageDownloadFailed)
            }
        }
        
        task.resume()
    }
    
    func buildSearchURL(query: String) -> URL? {
        
        let components: URLComponents = {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "api.flickr.com"
            components.path = "/services/rest"
            components.queryItems = [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "tags", value: query),
                URLQueryItem(name: "sort", value: "relevance"),
                URLQueryItem(name: "per_page", value: "40"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
            ]
            
            return components
        }()
        
        let url = components.url
        return url
    }
}
