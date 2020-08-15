//
//  UIViewController+Extensions.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import UIKit

public extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
}
