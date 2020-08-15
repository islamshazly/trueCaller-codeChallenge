//
//  MainViewModelTests.swift
//  TrueCallerAssignmentTests
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import Foundation
import XCTest
import RxSwift

@testable import TrueCallerAssignment

class MainViewModelTests: XCTestCase {
    
    var apiClient: APIClientMock?
    var mainService: MainService?
    var viewModel: MainViewModel?
    var disposeBag: DisposeBag?
    
    
    override func setUp() {
        super.setUp()
        
        apiClient = APIClientMock()
        mainService = MainServiceImpl(apiClient: apiClient!)
        viewModel = MainViewModel(service: mainService!)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        apiClient = nil
        mainService = nil
        disposeBag = nil
        
        super.tearDown()
    }
    
    func testTenthChatformStringReturn10thChar() {
        let html = "<​p> Truecaller Hello World </p>"
        apiClient?.html = html
        viewModel!.output.tenthChar.subscribe(onNext: { (char) in
            XCTAssertEqual(char, "a")
        }).disposed(by: disposeBag!)
    }
    
    func testEveryTenthCharFromStringReturnString() {
        let html = "<​p> Truecaller Hello World </p><​p> Truecaller Hello World </p><​p> Truecaller Hello World </p>"
         apiClient?.html = html
         viewModel!.output.everyTenthChar.subscribe(onNext: { (everyTenthChar) in
             XCTAssertEqual(everyTenthChar, "a o p e l < r H d")
         }).disposed(by: disposeBag!)
    }
    
    func testwordCoundFromStringReturnString() {
        let html = "Truecaller"
         apiClient?.html = html
         viewModel!.output.wordCount.subscribe(onNext: { (wordCount) in
            XCTAssertEqual(wordCount, "{\nTruecaller = 1;\n}")
         }).disposed(by: disposeBag!)
    }
}
