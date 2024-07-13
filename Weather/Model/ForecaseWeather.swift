//
//  ForecaseWeather.swift
//  Weather
//
//  Created by NERO on 7/13/24.
//

import Foundation

struct ForecaseWeather: Decodable {
    let list: [ForecaseInfo]
}

struct ForecaseInfo: Decodable {
    let main: WeatherDetail
    let weather: [WeatherInfo]
    let clouds: CloudInfo
    let wind: WindInfo
    let dt_txt: String
}
