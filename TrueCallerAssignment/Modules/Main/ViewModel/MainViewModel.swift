//
//  viewModel.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol
protocol Input {
    var refreshContent: AnyObserver<Void> { get }
}

protocol Output {
    var tenthChar: Observable<String> { get }
    var everyTenthChar: Observable<String> { get }
    var wordCount: Observable<String> { get }
    var showAlert: Observable<Error> { get }
    var startLoading: Observable<Bool> { get }
    var stopLoading: Observable<Bool> { get }
}

protocol viewModelTyps {
    var input: Input { get }
    var output: Output { get }
}

// MARK:- Class
final class MainViewModel: viewModelTyps,
    Input,
Output {
    
    
    // MARK: - Inputs & Outputs
    var input: Input { return self }
    var output: Output { return self }
    
    // MARK: - Inputs
    var refreshContent: AnyObserver<Void>
    
    // MARK: - Output
    var tenthChar: Observable<String>
    var everyTenthChar: Observable<String>
    var wordCount: Observable<String>
    var showAlert: Observable<Error>
    var startLoading: Observable<Bool>
    var stopLoading: Observable<Bool>
    
    // MARK: - Private Properties
    private let service: MainService
    private var refreshContentProperty = BehaviorSubject<Void>(value: ())
    private let showAlertProperty = PublishSubject<Error>()
    
    init(service: MainService) {
        self.service = service
        
        refreshContent = refreshContentProperty.asObserver()
        tenthChar = PublishSubject<String>().asObserver()
        everyTenthChar = PublishSubject<String>().asObserver()
        wordCount = PublishSubject<String>().asObserver()
        showAlert = showAlertProperty.asObserver()
        startLoading = PublishSubject<Bool>()
        stopLoading = PublishSubject<Bool>()
        get10thChar()
        getEvery10thChar()
        getWordCountthChar()
        stopLoading = Observable.zip(tenthChar, everyTenthChar, wordCount)
            .flatMapLatest { (_,_,_) -> Observable<Bool> in
                return Observable.just(false) }.catchError({ (_) -> Observable<Bool> in
                    return Observable.just(false)
                })
        
        startLoading = refreshContentProperty.flatMapLatest({ (_) -> Observable<Bool> in
            return Observable.just(true)
        })
    }
}
//MARK: - API calls
extension MainViewModel {
    private func get10thChar() {
        tenthChar = refreshContentProperty
            .flatMapLatest { [unowned self] _ in
                return self.service.truecaller10thCharacterRequest()
                    .catchError({ [unowned self] error in
                        self.showAlertProperty.onNext(error)
                        return Observable.empty() })}
            .map{ self.find10thChar(stringHTML: $0) }
            .share()
    }
    
    private func getEvery10thChar() {
        everyTenthChar = refreshContentProperty
            .flatMapLatest { [unowned self] _ in
                return self.service.truecallerEvery10thCharacterRequest()
                    .catchError({ [unowned self] error in
                        self.showAlertProperty.onNext(error)
                        return Observable.empty() })}
            .map{ self.findEvery10thChar(stringHTML: $0) }
            .share()
    }
    
    private func getWordCountthChar() {
        wordCount = refreshContentProperty
            .flatMapLatest { [unowned self] _ in
                return self.service.truecallerWordCounterRequest()
                    .catchError({ [unowned self] error in
                        self.showAlertProperty.onNext(error)
                        return Observable.empty() })}
            .map{ self.findWordCounter(stringHTML: $0) }
            .share()
    }
}
//MARK: - Find chars business Logic
extension MainViewModel {
    private func find10thChar(stringHTML: String) -> String {
        
        return "\(stringHTML[stringHTML.index(stringHTML.startIndex, offsetBy: 10)])"
    }
    
    private func findEvery10thChar(stringHTML: String) -> String {
        let result = stringHTML.enumerated()
            .map { $0.offset % 10 == 0 && $0.offset != 0 && !$0.element.isWhitespace ? "\($0.element)" : nil }
            .compactMap { $0 }
            .joined(separator: " ")
        
        return result
    }
    
    private func findWordCounter(stringHTML: String) -> String {
        var wordCounterMap: [String : Int] = [String : Int]()
        let _ = stringHTML.split{ $0.isWhitespace || $0.isNewline }
            .map { wordCounterMap["\($0)"] = (wordCounterMap["\($0)"] ?? 0) + 1 }
        
        do {
            let prettyString = try wordCounterMap.toPrttyString()
            return prettyString
        } catch _ {
            return "\(wordCounterMap)"
        }
    }
}
