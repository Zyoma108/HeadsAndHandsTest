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
    
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    
}

extension APIService {
    
    func fetchObservable() -> Observable<T> {
        // create request object
        let apiRequest = request(url, method: method, parameters: parameters)
        
        // create observable
        let observable: Observable<Data> = Observable.create({ observer in
            let requestQueue = DispatchQueue.global(qos: .utility)
    
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
        
        // map data and return in main queue
        return observable.observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)).map({ data -> T in
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print(error)
                throw CustomError(description: "Невозможно декодировать данные")
            }
        }).observeOn(MainScheduler.instance)
    }
    
}
