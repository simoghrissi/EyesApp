//
//  Network.swift
//  EyesApp
//
//  Created by simo on 23/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

enum ApiError: Error {
    case KO_TECHNIQUE
}

final class Network<T: Codable> {
    
    let jsonDecoder = JSONDecoder()
    private let endPoint: String = BuildConfig.sharedInstance.endpoint
    private let scheduler: ConcurrentDispatchQueueScheduler
    private var headers: [String: String] = [
        "Content-Type": "application/json"
        ]
    
    init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItem(_ path: String) -> Observable<(HTTPURLResponse, T)> {
        let absolutePath = "\(endPoint)/\(path)"
        
        return RxAlamofire
            .request(.get, absolutePath, headers: headers)
            //.debug()
            .observeOn(scheduler)
            .responseJSON().map{ reponse in
                let httpResponse = reponse.response
                let object = try? self.jsonDecoder.decode(T.self, from: reponse.data!)
                return (httpResponse!, object!)
        }
    }
    
    
    func getItem(_ path: String, parameters: [String: Any]?) -> Observable<(HTTPURLResponse, T)> {
        let absolutePath = "\(endPoint)/\(path)"
        
        return RxAlamofire
            .request(.get, absolutePath, parameters: parameters, headers: headers)
            //.debug()
            .observeOn(scheduler)
            .responseJSON().map{ reponse in
                let httpResponse = reponse.response
                let object = try? self.jsonDecoder.decode(T.self, from: reponse.data!)
                return (httpResponse!, object!)
        }
    }
    
    func postItem(_ path: String, parameters: [String: Any]?) -> Observable<(HTTPURLResponse, T)> {
        let absolutePath = "\(endPoint)/\(path)"
                
        return RxAlamofire
            .request(.post, absolutePath, parameters: parameters,encoding:JSONEncoding.default, headers: headers)
            //.debug()
            .observeOn(scheduler)
            .responseJSON().map{ reponse in
                let httpResponse = reponse.response
                let object = try? self.jsonDecoder.decode(T.self, from: reponse.data!)
                return (httpResponse!, object!)
            }
    }
    
    func postItemWithoutResponse(_ path: String, parameters: [String: Any]) -> Observable<(HTTPURLResponse, Data)> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .requestData(.post, absolutePath, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .observeOn(scheduler)
    }
    
    func putItem(_ path: String, parameters: [String: Any]?) -> Observable<(HTTPURLResponse, T)> {
        let absolutePath = "\(endPoint)/\(path)"
        
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters, headers: headers)
            //.debug()
            .observeOn(scheduler)
            .responseJSON().map{ reponse in
                let httpResponse = reponse.response
                let object = try? self.jsonDecoder.decode(T.self, from: reponse.data!)
                return (httpResponse!, object!)
        }
    }
    
    func deleteItem(_ path: String, parameters: [String: Any]?) -> Observable<(HTTPURLResponse, T)> {
        let absolutePath = "\(endPoint)/\(path)"
        
        return RxAlamofire
            .request(.delete, absolutePath, parameters: parameters, headers: headers)
            //.debug()
            .observeOn(scheduler)
            .responseJSON().map{ reponse in
                let httpResponse = reponse.response
                let object = try? self.jsonDecoder.decode(T.self, from: reponse.data!)
                return (httpResponse!, object!)
        }
    }
}

