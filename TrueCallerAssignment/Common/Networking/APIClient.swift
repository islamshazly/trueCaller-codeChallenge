//
//  NetworkManager.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocols
protocol APIClient: class {
    
    func start(request: Request)-> Observable<String>
}

// MARK: - Class
final class ApiClientImpl: APIClient {
    
    // MARK: - Private Properties
    private var session: URLSession
    
    // MARK: - Init
    init() {
        self.session = URLSession.shared
    }
    
    // MARK: - Helping Methods
    func start(request: Request) -> Observable<String> {
        guard let url = request.fullURL  else {
            
            return Observable.error(generateError(description: "Invalid URL"))
        }
        let urlRequest = URLRequest(url: url)
        return session.rx.data(request: urlRequest)
            .flatMapLatest { [unowned self] data throws -> Observable<String> in
                guard let html = String(decoding: data, as: UTF8.self) as? String else {
                    return Observable.error(self.generateError(description: "Can not parse"))
                }
                return Observable.just(html)}
    }
    
    func generateError(description: String) -> NSError {
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey: description,
            NSLocalizedFailureReasonErrorKey: description
        ]
        let error = NSError(domain: description, code: 1000, userInfo: userInfo)
        return error
    }
}
