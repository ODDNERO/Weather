//
//  CurrentWeather.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import Foundation

struct CurrentWeather: Decodable {
    let coord: Coordinate
    let weather: [WeatherInfo]
    let main: WeatherDetail
    let wind: WindInfo
    let clouds: CloudInfo
    let id: Int
    let name: String
}
