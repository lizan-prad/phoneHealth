//
//  NetworkManager.swift
//  VenueFinder
//
//  Created by Lizan on 21/12/2021.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    
    typealias CompletionHandler<T: Mappable> = (Result<T, Error>) -> ()
    
    func request<T: Mappable>(_ value: T.Type ,urlExt: String, method: HTTPMethod, param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping CompletionHandler<T>){
        
        let header = headers == nil ? ["Accept" : "application/json", "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5ODE4ODA0MTI2IiwiZXhwIjoxNjc2NjI3ODk0LCJpYXQiOjE2NDUwOTE4OTR9.qwvgoOAvgcisBb5z7F589CA2TvXnIUgzN86HktHDuNlpKFOeqNre46OIrUfvWLn7g6cg7nFVcDZDQ3mHMuRz1w"] /*"Bearer \(UserDefaults.standard.string(forKey: "AT") ?? "")"]*/ : headers
        
        AF.request(urlExt, method: method, parameters: param, encoding: encoding, headers: header).responseJSON { (response) in
            print(response.result)
            switch response.result {
            case .success(let data):
                if let data = data as? [String:Any], let model = Mapper<T>().map(JSON: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        }
    }
       
}
