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

struct WeatherInfo: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct WeatherDetail: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WindInfo: Decodable {
    let speed: Double
    let gust: Double
}

struct CloudInfo: Decodable {
    let all: Int
}
