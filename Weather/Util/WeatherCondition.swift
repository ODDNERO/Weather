//
//  WeatherCondition.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import UIKit

enum WeatherCondition: String, CaseIterable {
    case Thunderstorm
    case Drizzle
    case Rain
    case Snow
    case Sand
    case Ash
    case Clear
    case Clouds
    case Default
    
    static func convertCase(condition: String) -> WeatherCondition? {
        let filterList = WeatherCondition.allCases.filter { $0.rawValue == condition }
        return filterList.first ?? .Default
    }
    
    var color: UIColor {
        switch self {
        case .Thunderstorm: #colorLiteral(red: 0.3297539353, green: 0.3699304461, blue: 0.881400764, alpha: 1)
        case .Drizzle:      #colorLiteral(red: 0.7657927871, green: 0.7491346598, blue: 1, alpha: 1)
        case .Rain:         #colorLiteral(red: 0.2464889586, green: 0.5359176993, blue: 0.7451709509, alpha: 1)
        case .Snow:         #colorLiteral(red: 0.7839071751, green: 0.9491086602, blue: 1, alpha: 1)
        case .Sand:         #colorLiteral(red: 0.8074274659, green: 0.7095568776, blue: 0.6374845505, alpha: 1)
        case .Ash:          #colorLiteral(red: 0.7709046602, green: 0.3454347253, blue: 0.3377197385, alpha: 1)
        case .Clear:        #colorLiteral(red: 0.1416646242, green: 0.8834002614, blue: 0.9987313151, alpha: 1)
        case .Clouds:       #colorLiteral(red: 0.4608690143, green: 0.6344835758, blue: 0.9882474542, alpha: 1)
        case .Default:      #colorLiteral(red: 0.6325227022, green: 0.7230103612, blue: 0.7988564968, alpha: 1)
        }
    }
}
