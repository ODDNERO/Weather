//
//  Country.swift
//  Weather
//
//  Created by NERO on 7/15/24.
//

import Foundation

enum Country: String, CaseIterable {
    case KR
    case US
    case HK
    case JP
    
    static func convertCase(_ country: String) -> Country? {
        let filterList = Country.allCases.filter { $0.rawValue == country }
        return filterList.first ?? nil
    }
}

enum State: String, CaseIterable {
    case TX
    case CA
    
    static func convertCase(_ state: String) -> State? {
        let filterList = State.allCases.filter { $0.rawValue == state }
        return filterList.first ?? nil
    }
}
