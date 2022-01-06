//
//  NetworkManager.swift
//  VenueFinder
//
//  Created by Lizan on 21/12/2021.
//

import UIKit
import CoreData

class NetworkManager {
    
    static let shared = NetworkManager()
    
    fileprivate enum RequestMethods: String {
        case get = "GET"
        case post = "POST"
    }
    
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> ()
    
    
    func request<T: Decodable>(_ type: T.Type, withEndpoint url: URL, params: [String: String], needsAuthorization: Bool = true, header: [String:String]? = nil, completion: @escaping CompletionHandler<T>) {
        URLSession.shared.dataTask(with: EndPointRequest.getURLRequest(url, withParameters: params)) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let json = data else {
                completion(.failure(NSError.init(domain: "NetworkManager", code: 400, userInfo: [NSLocalizedDescriptionKey: "No Data!"])))
                return
            }
            DispatchQueue.main.async {
//                self.coreDataDecoder(T.self, json: json, completion: completion)
            }
        }.resume()
    }
}


class EndPointRequest {
    
    static func getURLRequest(_ endPoint: URL, withParameters param: [String: String]) -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.absoluteString)
        var localVariable = urlComponents
        urlComponents?.queryItems = param.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        localVariable?.queryItems = urlComponents?.queryItems
        urlComponents?.percentEncodedQuery = localVariable?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: urlComponents?.url ?? endPoint)
        request.httpMethod = NetworkManager.RequestMethods.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(URLConfig.apiKey, forHTTPHeaderField: "Authorization")
        return request
    }
    
}
