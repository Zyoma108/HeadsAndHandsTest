//
//  LoginViewModel.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 17/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel: BaseViewModel {
    
    private let city = "Moscow"
    
    let errorSubject = PublishSubject<String>()
    let weatherSubject = PublishSubject<String>()
    let isLoadingSubject = PublishSubject<Bool>()
    
    var email: String?
    var password: String?
    
    func login() {
        // validate email
        guard let email = email, !email.isEmpty else {
            errorSubject.onNext("Поле ввода почты пустое")
            return
        }
        
        guard email.isValidEmail else {
            errorSubject.onNext("Введен некоректный адрес почты")
            return
        }

        // validate password
        guard let password = password, !password.isEmpty else {
            errorSubject.onNext("Поле ввода пароля пустое")
            return
        }
        
        guard password.isValidPassword else {
            errorSubject.onNext("Пароль должен содержать минимум 6 символов, минимум 1 строчную букву, 1 заглавную, и 1 цифру")
            return
        }
        
        fetchWeather()
    }
    
    private func fetchWeather() {
        let service = WeatherService(city: city)
        
        startLoading()
        service.fetchObservable().subscribe(onNext: { [weak self] weather in
            self?.weatherSubject.onNext(weather.description)
        }, onError: { [weak self] error in
            self?.errorSubject.onNext(error.localizedDescription)
        }, onCompleted: { [weak self] in
            self?.stopLoading()
        }).disposed(by: disposeBag)
    }
    
    private func startLoading() { isLoadingSubject.onNext(true) }
    
    private func stopLoading() { isLoadingSubject.onNext(false) }
}
