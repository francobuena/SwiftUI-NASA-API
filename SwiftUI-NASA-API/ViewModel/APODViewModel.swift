//
//  APODViewModel.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 23/5/2022.
//

import Foundation
import Combine

class APODViewModel: ObservableObject {
    @Published var apod: APOD?
    @Published var apodList: [APOD] = []
    private let nasaNetwork = NASAApiNetwork()
    var errorText = "Unknown error"
    private var cancellable = Set<AnyCancellable>()
    
    func fetchAPOD() {
        
        let request = nasaNetwork.getEndpoint(urlString: Constants.apiURL + Constants.apiKey)
        
        nasaNetwork.fetchAPOD(request: request)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.errorText = error.localizedDescription
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.apod = response
                })
            .store(in: &cancellable)
    }
    
    func fetchAPODList() {
        let startDate = Date.getDate(forLastNDays: -7)
        let endDate = Date.getDate(forLastNDays: 0)
        
        let request = nasaNetwork.getEndpoint(urlString: Constants.apiURL + Constants.apiKey + "&start_date=\(startDate)&end_date=\(endDate)")
        
        nasaNetwork.fetchAPODRange(request: request)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.errorText = error.localizedDescription
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.apodList = response.reversed()
                })
            .store(in: &cancellable)
    }
    
    
}
