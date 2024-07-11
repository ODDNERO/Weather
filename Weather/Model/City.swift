//
//  City.swift
//  Weather
//
//  Created by NERO on 7/11/24.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coordinate
}

struct Coordinate: Decodable {
    let lon: Double
    let lat: Double
}
