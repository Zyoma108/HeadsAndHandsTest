//
//  API.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol APIService {
    
    associatedtype T: Decodable
    
    static func mapper(data: Data) throws -> T
    
}

extension APIService {
    
    static func fetch(url: String, parameters: [String: Any], method: HTTPMethod) -> Observable<T> {
        return Observable.create({ observer in
            let requestQueue = DispatchQueue.global(qos: .utility)
            let apiRequest = request(url, method: method, parameters: parameters)
            apiRequest.response(queue: requestQueue) { response in
                if let error = response.error {
                    observer.onError(error)
                } else if let data = response.data {
                    observer.onNext(data)
                } else {
                    observer.onError(CustomError(description: "Неизвестная ошибка"))
                }
                observer.onCompleted()
            }
            
            return Disposables.create { apiRequest.cancel() }
        }).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .map(mapper)
            .observeOn(MainScheduler.instance)
    }
    
}
