//
//  UIViewController+Extension.swift
//  OpenAPI
//
//  Created by 박희지 on 1/18/24.
//

import UIKit

extension UIViewController: Reusable {
    static var identfiler: String {
        return String(describing: self)
    }
}
