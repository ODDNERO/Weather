//
//  DailyWeather.swift
//  Weather
//
//  Created by NERO on 7/15/24.
//

import Foundation

struct DailyWeather: Decodable {
    let city: CityInfo
    let list: [DailyInfo]
}

struct CityInfo: Decodable {
    let timezone: Int
}

struct DailyInfo: Decodable {
    let dt: Int
    let temp: TempDetail
    let weather: [WeatherInfo]
}

struct TempDetail: Decodable {
    let min: Double
    let max: Double
}
