//
//  APIManager.swift
//  Weather
//
//  Created by NERO on 7/11/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static func requestAPI<T: Decodable>(_ API: APIRouter,
                                         completionHandler: @escaping (Result<T, Error>) -> Void) {
        AF.request(API.endpoint,
                   method: API.method,
                   parameters: API.parameter,
                   encoding: URLEncoding(destination: .queryString))
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
