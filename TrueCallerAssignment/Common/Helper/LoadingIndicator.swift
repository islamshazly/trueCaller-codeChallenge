//
//  LoadingIndicator.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 17/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import UIKit
import MBProgressHUD

// MARK: - Protocols
protocol LoadingViewable {
    func startLoadingIndicator()
    func stopLoadingIndicator()
}

// MARK: - Default Implementation
extension LoadingViewable where Self: UIViewController {
    func startLoadingIndicator() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func stopLoadingIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}


