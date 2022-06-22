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
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var currentRequest: RequestType = .lastWeek
    var errorText = "Unknown error"
    var currentDate = Date.getDate(forLastNDays: -8)
    private let nasaNetwork = NASAApiNetwork()
    private var cancellable = Set<AnyCancellable>()
    // NASA Api is a day behind AUS so I must fetch from the day before
    private let startDate = Date.getDate(forLastNDays: -8)
    private let endDate = Date.getDate(forLastNDays: -1)
    
    func fetchAPODList() {
        
        var request: URLRequest
        
        switch currentRequest {
        case .lastWeek:
            request = NASAEndpoint.range(startDate: startDate, endDate: endDate).request()
        case .randomImage:
            request = NASAEndpoint.random.request()
        case .pickADate:
            request = NASAEndpoint.date(date: "2021-01-01").request()
        }
        
        self.isLoading = true
        nasaNetwork.fetchAPODRange(request: request)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.errorText = error.localizedDescription
                        self.isLoading = false
                        self.showAlert = true
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.apodList = response.reversed()
                })
            .store(in: &cancellable)
    }
    
}
