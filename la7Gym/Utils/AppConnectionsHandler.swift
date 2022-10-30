//
//  AppConnectionsHandler.swift
//  Bahya
//
//  Created by mohamed elmaazy on 5/16/18.
//  Copyright © 2018 mohamed elmaazy. All rights reserved.
//

import Foundation
import Alamofire
    
public enum ResponseStatus {
    case sucess
    case error
}

class AppConnectionsHandler {
    
    static func checkConnection() -> Bool {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")!
        return (reachabilityManager.isReachable)
    }
    
    static func setParamsInUrl(_ params: [String: Any]) -> String {
        var returnString = "?"
        for (key, value) in params {
            returnString += "\(key)=\(value)&"
        }
        returnString.removeLast()
        return returnString
    }
    
    fileprivate static func getRequest(url: String, parameters: [String: Any], headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        do {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let decoded = String(data: jsonData, encoding: .utf8)!
            let postData = decoded.data(using: .utf8)
            request.httpBody = postData
            print("JsonRequest: \(decoded)")
            return request
        } catch {
            return URLRequest(url: URL(string: url)!)
        }
    }
    
    static func get<T: Decodable>(url: String, params: [String: Any]? = GET_DEFAULT_PARAMS(), headers: [String: String]? = nil, type: T.Type, completion: ((ResponseStatus, Decodable?, String?) -> Void)?) {
        if checkConnection() {
            var url = url
            url += setParamsInUrl(params!)
            let safeUrl = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
            print("url: \(safeUrl)")
            Alamofire.request(safeUrl, method: HTTPMethod.get , encoding: JSONEncoding.default, headers: headers).responseJSON {
                (response:DataResponse<Any>) in
                let result = handlerResponse(response: response, type: T.self)
                completion?(result.0, result.1, result.2)
            }
        } else {
            completion?(.error, nil, "errorInConnection".localize)
        }
    }
    
    static func post<T: Decodable>(url: String, params: [String:Any]? = nil, headers: [String:String]? = nil, type: T.Type, completion: ((ResponseStatus, Decodable?, String?) -> Void)?) {
        print("url: \(url)")
        print("post")
        print("params: \(params)")
        if checkConnection() {
            Alamofire.request(url, method: .post, parameters:params , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                let result = handlerResponse(response: response, type: T.self)
                completion?(result.0, result.1, result.2)
            }
        } else {
            completion?(.error, nil, "errorInConnection".localize)
        }
    }
    
    static func raw<T: Decodable>(url: String, params: [String: Any], headers: [String: String]? = nil, type: T.Type, completion: ((ResponseStatus, Decodable?, String?) -> Void)?) {
        print("url: \(url)")
        print("get")
        if checkConnection() {
            Alamofire.request(getRequest(url: url, parameters: params, headers: headers)).responseJSON { (response:DataResponse<Any>) in
                let result = handlerResponse(response: response, type: T.self)
                completion?(result.0, result.1, result.2)
            }
        } else {
            completion?(.error, nil, "errorInConnection".localize)
        }
    }
    
    static func upload<T: Decodable>(url: String, params: [String:Any]?, headers :[String:String]?, images: [UIImage], imageRequestKey: String, type: T.Type, completion: ((ResponseStatus, Decodable?, String?) -> Void)?) {
        if checkConnection() {
            var url = try! URLRequest(url: URL(string:url)!, method: .post, headers: headers)
            url.timeoutInterval = 200
            Alamofire.upload(multipartFormData: { multipartFormData in
                if images.count != 0 {
                    for (i, image) in images.enumerated() {
                        let name = "\(Date().timeIntervalSince1970 * 100000)" + "." + "jpg"
                        multipartFormData.append(image.getThumbnial().jpegData(compressionQuality:1)!, withName: "\(imageRequestKey)[\(i)]", fileName: name , mimeType: "image/jpeg")
                    }
                }
                for (key, value) in params ?? [:] {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }, with: url,
               encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        let result = handlerResponse(response: response, type: T.self)
                        completion?(result.0, result.1, result.2)
                    }
                    break
                case .failure( _):
                    completion?(.error, nil, "errorInConnection".localize)
                    break
                }
            })
        } else {
            completion?(.error, nil, "errorInConnection".localize)
        }
    }
    
    static func uploadImageFiles<T: Decodable>(url: String, params: [String:Any]?, headers :[String:String]?, images: [UIImage] = [UIImage](), imageRequestKey: String = "",files:[Data],fileRequestKey:String,fileNames:[String], type: T.Type, completion: ((ResponseStatus, Decodable?, String?) -> Void)?) {
        if checkConnection() {
            var url = try! URLRequest(url: URL(string:url)!, method: .post, headers: headers)
            url.timeoutInterval = 200
            Alamofire.upload(multipartFormData: { multipartFormData in
                if images.count != 0 {
                    for (i, image) in images.enumerated() {
                        let name = "\(Date().timeIntervalSince1970 * 100000)" + "." + "jpg"
                        multipartFormData.append(image.getThumbnial().jpegData(compressionQuality:1)!, withName: "\(imageRequestKey)[\(i)]", fileName: name , mimeType: "image/jpeg")
                    }
                }
                if files.count != 0{
                    for (i, file) in files.enumerated() {
                        let name = fileNames[i]
                        multipartFormData.append(file, withName: fileRequestKey, fileName: name , mimeType: "image/jpeg")
                    }
                }
                for (key, value) in params ?? [:] {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }, with: url,
               encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        let result = handlerResponse(response: response, type: T.self)
                        completion?(result.0, result.1, result.2)
                    }
                    break
                case .failure( _):
                    completion?(.error, nil, "errorInConnection".localize)
                    break
                }
            })
        } else {
            completion?(.error, nil, "errorInConnection".localize)
        }
    }
    
    fileprivate static func handlerResponse<T: Decodable>(response: DataResponse<Any>, type: T.Type) -> (ResponseStatus, Decodable?, String?) {
        switch(response.result) {
        case .success(_):
            if response.result.value != nil {
                let dic = response.result.value! as? [String : Any] ?? [String: Any]()
                if dic["status"] as? Int == 1 {
                    let jsonData = try? JSONSerialization.data(withJSONObject: handleJSONObject(dicc: dic))
                    let model = try! JSONDecoder().decode(T.self, from: jsonData!)
                    return(.sucess, model, nil)
                } else {
                    return(.error, nil, dic["message"] as? String ?? "Error in connection".localize)
                }
            } else {
                return(.error, nil, "Error in connection".localize)
            }
        case .failure(_):
            return(.error, nil, "Error in connection".localize)
        }
    }
    
    static func handleJSONObject(dicc: [String: Any]) -> [String: Any] {
        var dic = dicc
        for (key, value) in dic {
            if value is Int {
                let temp : Int =  value as! Int
                dic[key] = String(temp)
            } else if value is Double {
                let temp : Double = value as! Double
                dic[key] = String(temp)
            } else if value is Bool {
                let temp : Bool = value as! Bool
                dic[key] = String(temp)
            } else if value is [String: Any] {
                dic[key] = handleJSONObject(dicc: value as! [String : Any])
            } else if value is [[String: Any]] {
                var newValue = [[String: Any]]()
                for val in value as! [[String: Any]] {
                    newValue.append(handleJSONObject(dicc: val))
                }
                dic[key] = newValue
            }
        }
        return dic
    }
    
    static func handleJSONArray(dic: [[String: Any]]) -> [[String: Any]] {
        var newValue = [[String: Any]]()
        for item in dic{
            newValue.append(handleJSONObject(dicc: item))
        }
        return newValue
    }
}
