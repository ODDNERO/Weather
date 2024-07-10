//
//  Observable.swift
//  Weather
//
//  Created by NERO on 7/10/24.
//

import Foundation

final class Observable<T> {
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            self.closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
