//
//  UIViewController+Extension.swift
//  OpenAPI
//
//  Created by 박희지 on 1/18/24.
//

import UIKit

protocol Reusable: AnyObject {
    static var identfiler: String { get }
}

extension UIViewController: Reusable {
    static var identfiler: String {
        return String(describing: self)
    }
}

