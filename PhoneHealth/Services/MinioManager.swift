//
//  MinioManager.swift
//  PhoneHealth
//
//  Created by Lizan on 20/02/2022.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON

class MinioManager {
    
    static let shared = MinioManager()
    
    typealias CompletionHandler = (Result<String, Error>) -> ()
    
    func requestMinioUrl(param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping CompletionHandler){
        
        let header = headers == nil ? ["Accept" : "application/json", "Authorization":  "Bearer \(UserDefaults.standard.string(forKey: "AT") ?? "")"] : headers
//        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5ODE4ODA0MTI2IiwiZXhwIjoxNjc2NjI3ODk0LCJpYXQiOjE2NDUwOTE4OTR9.qwvgoOAvgcisBb5z7F589CA2TvXnIUgzN86HktHDuNlpKFOeqNre46OIrUfvWLn7g6cg7nFVcDZDQ3mHMuRz1w"]
        AF.request(URLConfig.baseUrl + "file/putPresignedURL", method: .put, parameters: param, encoding: encoding, headers: header).responseJSON { (response) in
            if let data = response.data, let url = String.init(data: data, encoding: .utf8) {
                completion(.success(url))
            }
        }
    }
    
    func upload(image: [Data], to url: Alamofire.URLRequestConvertible, params: [String: Any]) {
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            image.forEach { data in
                multiPart.append(data, withName: "", fileName: "", mimeType: "image/png")
            }
        }, with: url)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
                if let json = try? JSON.init(data: data.data ?? Data()) {
                    print(json)
                }
            })
    }
}
