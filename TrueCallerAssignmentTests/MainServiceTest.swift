//
//  MainServiceTest.swift
//  TrueCallerAssignmentTests
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import XCTest
import RxSwift

@testable import TrueCallerAssignment

final class MainServiceTest: XCTestCase {
    
    var apiClient: APIClientMock?
    var mainService: MainService?
    var disposeBag: DisposeBag?
    
    override func setUp() {
        super.setUp()
        
        apiClient = APIClientMock()
        mainService =   MainServiceImpl(apiClient: apiClient!)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        apiClient = nil
        mainService = nil
        disposeBag = nil
        
        super.tearDown()
    }
    
    func testTruecaller10thCharacterRequestWithInternetConnectionReturnStirng() {
        let html = "<​p> Truecaller Hello World </p>"
        apiClient?.html = html
        let _ = mainService!
            .truecaller10thCharacterRequest()
            .subscribe(onNext: { (string) in
            XCTAssertEqual(string, html) })
            .disposed(by: disposeBag!)
    }
    
    func testTruecaller10thCharacterRequestWithNoInternetConnectionReturnError() {
        let error = generateError(description: "Error")
        apiClient?.error = error
        let _ = mainService!
            .truecaller10thCharacterRequest()
            .subscribe(onError: { (returnError) in
            XCTAssertEqual(error.localizedDescription, returnError.localizedDescription)})
            .disposed(by: disposeBag!)
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
