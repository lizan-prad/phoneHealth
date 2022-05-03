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
        
        let header = headers == nil ? ["Accept" : "application/json", "Authorization":  "Bearer \(UserDefaults.standard.string(forKey: "AT") ?? "")"] : headers
//        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5ODE4ODA0MTI2IiwiZXhwIjoxNjc2NjI3ODk0LCJpYXQiOjE2NDUwOTE4OTR9.qwvgoOAvgcisBb5z7F589CA2TvXnIUgzN86HktHDuNlpKFOeqNre46OIrUfvWLn7g6cg7nFVcDZDQ3mHMuRz1w"]
        AF.request(urlExt, method: method, parameters: param, encoding: encoding, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                if let data = data as? [String:Any], let model = Mapper<T>().map(JSON: data) {
                    print(data)
                    if (400 ... 405).contains(response.response?.statusCode ?? 0) {
                        if let error = data["error"] as? String {
                            completion(.failure(NSError.init(domain: "login", code: 0, userInfo:   [NSLocalizedDescriptionKey: error]  )))
                        } else {
                        completion(.failure(NSError.init(domain: "login", code: 0, userInfo:   [NSLocalizedDescriptionKey: (data["errorMessage"] as? String) ?? ""]  )))
                        }
                    } else {
                        completion(.success(model))
                    }
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        }
    }
    
    func requestData(urlExt: String, method: HTTPMethod, param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (Data) -> ()){
        
        let header = headers == nil ? ["Accept" : "application/json", "Authorization":  "Bearer \(UserDefaults.standard.string(forKey: "AT") ?? "")"] : headers
//        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5ODE4ODA0MTI2IiwiZXhwIjoxNjc2NjI3ODk0LCJpYXQiOjE2NDUwOTE4OTR9.qwvgoOAvgcisBb5z7F589CA2TvXnIUgzN86HktHDuNlpKFOeqNre46OIrUfvWLn7g6cg7nFVcDZDQ3mHMuRz1w"]
        AF.request(urlExt, method: method, parameters: param, encoding: encoding, headers: header).responseData { data in
            if let data = data.data {
                completion(data)
            }
        }
    }
    
    func requestMultipart<T: Mappable>(_value: T.Type, param:[String: Any],arrImage:[UIImage],imageKey:String,URlName:String,controller:UIViewController, withblock:@escaping (_ response: AnyObject?)->Void){

        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data", "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "AT") ?? "")"]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in param {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for img in arrImage {
                guard let imgData = img.jpegData(compressionQuality: 1) else { return }
                multipartFormData.append(imgData, withName: imageKey, fileName: "\(Date().timeIntervalSince1970)" + ".jpeg", mimeType: "image/jpeg")
            }
            
            
        },to: URL.init(string: URLConfig.baseUrl + URlName)!, usingThreshold: UInt64.init(),
          method: .post,
          headers: headers).response{ response in
            
            if((response.error != nil)){
                do{
                    if let jsonData = response.data{
                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                        print(parsedData)
                        
                        let status = parsedData["responseStatus"] as? NSInteger ?? 0
                        
                        if (status == 1){
                            if let model = Mapper<T>().map(JSONObject: parsedData) {
                                print(model)
                            }
                            
                        }else if (status == 2){
                            print("error message")
                        }else{
                            print("error message")
                        }
                    }
                }catch{
                    print("error message")
                }
            }else{
                 print(response.error!.localizedDescription)
            }
        }
    }
       
}
