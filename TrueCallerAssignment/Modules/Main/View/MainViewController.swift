//
//  ViewController.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    
    //MARK: - outlets
    
    @IBOutlet private weak var tenthCharTV: UITextView!
    @IBOutlet private weak var everyTenthCharTV: UITextView!
    @IBOutlet private weak var woredCountTV: UITextView!
    @IBOutlet private weak var refreshButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupBindings()
    }
}

// MARK: - Setup
extension MainViewController {
    func setupBindings () {
        let output =  viewModel.output
        let input =  viewModel.input
        
        output.stopLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.stopLoadingIndicator()})
            .disposed(by: disposeBag)
        output.startLoading
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [unowned self] _ in
            self.startLoadingIndicator()})
        .disposed(by: disposeBag)
        
        output.showAlert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] (error) in
            self.showErrorAlert(error: error)
        }).disposed(by: disposeBag)
        
        output.tenthChar
            .bind(to: tenthCharTV.rx.text)
            .disposed(by: disposeBag)
        output.everyTenthChar
            .bind(to: everyTenthCharTV.rx.text)
            .disposed(by: disposeBag)
        output.wordCount
            .bind(to: woredCountTV.rx.text)
            .disposed(by: disposeBag)
        
        refreshButton.rx.tap
            .bind(to: input.refreshContent)
            .disposed(by: disposeBag)
    }
}

