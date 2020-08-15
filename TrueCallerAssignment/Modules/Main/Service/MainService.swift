//
//  service.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocols
protocol MainService {
    func truecaller10thCharacterRequest() -> Observable<String>
    func truecallerEvery10thCharacterRequest() -> Observable<String>
    func truecallerWordCounterRequest() -> Observable<String>
}

// MARK: - Class
final class MainServiceImpl {
    private var apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}
// MARK: - Api Calls 
extension MainServiceImpl: MainService {
    func truecaller10thCharacterRequest() -> Observable<String> {
        let request = TrueCallerAPI.tenthChar
        return apiClient.start(request: request)
    }
    
    func truecallerEvery10thCharacterRequest() -> Observable<String> {
        let request = TrueCallerAPI.everyTenthChar
        return apiClient.start(request: request)
    }
    
    func truecallerWordCounterRequest() -> Observable<String> {
        let request = TrueCallerAPI.wordCount
        return apiClient.start(request: request)
    }
}
