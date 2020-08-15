//
//  AlertView.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import UIKit

extension UIViewController: LoadingViewable {
    func showErrorAlert(error: Error) {
        self.showAlert(string: error.localizedDescription)
    }
    
    func showAlert(string: String) {
        let alert = UIAlertController(title: "OPS",
                                      message: string,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        if let presented = self.presentedViewController {
            presented.removeFromParent()
          }
        if presentedViewController == nil {
            stopLoadingIndicator()
             self.present(alert, animated: true, completion: nil)
          }
    }
}
