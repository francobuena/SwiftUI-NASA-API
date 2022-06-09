//
//  Endpoint.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 7/6/2022.
//

import Foundation

enum Endpoint {
    
    private struct Constants {
        static let baseURL = "https://api.nasa.gov/planetary/apod"
        static let apiKey = "?api_key=G8cmT6a4HeCUE8O1JIxatK484sAMdmzgUX1AZeCb"
        static let thumbs = "&thumbs=true"
    }
    
    case today
    case random
    case date(date: String)
    case range(startDate: String, endDate: String)
    
    private func path() -> String {
        var endpoint: String
        switch self {
        case .today:
            endpoint = ""
        case .random:
            endpoint = "&count=1"
        case .date(let date):
            endpoint = "&date=\(date)"
        case .range(let startDate, let endDate):
            endpoint = "&start_date=\(startDate)&end_date=\(endDate)"
        }
        return endpoint
    }
    
    func request() -> URLRequest {
        
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.apiKey)\(Constants.thumbs)\(path())") else {
            fatalError("Invalid url")
        }
        
        return URLRequest(url: url)
    }
}
