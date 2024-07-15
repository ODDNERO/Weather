//
//  JSONParser.swift
//  Weather
//
//  Created by NERO on 7/15/24.
//

import Foundation

enum JSONParser {
    static func fetchBundleDataParsedModel<T: Decodable>(_ file: String, to model: T.Type) -> T? {
        guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: fileURL)
            let parsedModel = try JSONDecoder().decode(model, from: data)
            return parsedModel
        } catch {
            print(error)
            return nil
        }
    }
}
