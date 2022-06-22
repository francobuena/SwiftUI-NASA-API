//
//  NASAAPINetwork.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 23/5/2022.
//

import Foundation
import Combine

protocol NASAServices {
    func fetchAPODRange(request: URLRequest) -> AnyPublisher<[APOD], Error>
}

class NASAApiNetwork: NASAServices {
    func fetchAPODRange(request: URLRequest) -> AnyPublisher<[APOD], Error> {
        return fetchRequest(with: request)
    }
    
    private func fetchRequest<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request).map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
