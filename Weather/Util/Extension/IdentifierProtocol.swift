//
//  IdentifierProtocol.swift
//  Weather
//
//  Created by NERO on 7/11/24.
//

import UIKit

protocol IdentifierProtocol: AnyObject {
    static var identifier: String { get }
}

extension UIView: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

