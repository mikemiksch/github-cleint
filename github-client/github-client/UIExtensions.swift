//
//  UIExtensions.swift
//  github-client
//
//  Created by Mike Miksch on 4/4/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
