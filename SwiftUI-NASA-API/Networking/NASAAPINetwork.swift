//
//  NASAAPINetwork.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 23/5/2022.
//

import Foundation
import Combine

protocol NASAServices {
    func fetchAPOD(request: URLRequest) -> AnyPublisher<APOD, Error>
    func fetchAPODRange(request: URLRequest) -> AnyPublisher<[APOD], Error>
}

class NASAApiNetwork: NASAServices {
    func fetchAPOD(request: URLRequest) -> AnyPublisher<APOD, Error> {
        return fetchRequest(with: request)
    }
    
    func fetchAPODRange(request: URLRequest) -> AnyPublisher<[APOD], Error> {
        return fetchRequest(with: request)
    }
    
    func getEndpoint(urlString: String) -> URLRequest {
        guard let url = URL(string: urlString) else { fatalError("Invalid URL") }
        return URLRequest(url: url)
    }
    
    private func fetchRequest<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request).map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
