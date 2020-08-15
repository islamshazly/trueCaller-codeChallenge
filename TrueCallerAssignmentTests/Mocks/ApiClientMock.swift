//
//  ApiClientMock.swift
//  TrueCallerAssignmentTests
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import XCTest
import RxSwift

@testable import TrueCallerAssignment

final class APIClientMock: APIClient {
    
    var html: String?
    var error: Error?
    
    func start(request: Request) -> Observable<String> {
        if let html = html {
            return Observable.just(html)
        } else if let error = error  {
            return Observable.error(error)
        }
        return  Observable.empty()
    }
}
