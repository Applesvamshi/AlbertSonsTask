//
//  utility.swift
//  Demo
//
//  Created by Vamshi on 17/07/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case httpError(Int)
}
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
class constants{
    
    static let baseUrl = "https://www.jsonkeeper.com/b/6JS0"
}



