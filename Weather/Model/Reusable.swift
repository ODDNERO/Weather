//
//  Coordinate.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import Foundation

struct Coordinate: Decodable {
    let lon: Double
    let lat: Double
}

struct WeatherInfo: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct CloudInfo: Decodable {
    let all: Int
}

struct WindInfo: Decodable {
    let speed: Double
    let gust: Double?
}

struct WeatherDetail: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
