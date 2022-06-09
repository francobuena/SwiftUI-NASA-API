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
    private let nasaNetwork = NASAApiNetwork()
    var errorText = "Unknown error"
    private var cancellable = Set<AnyCancellable>()
    
    func fetchAPOD() {
        
        let request = Endpoint.today.request()
        
        nasaNetwork.fetchAPOD(request: request)
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
                    self.apod = response
                })
            .store(in: &cancellable)
    }
    
    func fetchAPODList() {
        // NASA Api is a day behind AUS so I must fetch from the day before
        let startDate = Date.getDate(forLastNDays: -8)
        let endDate = Date.getDate(forLastNDays: -1)
        
        let request = Endpoint.range(startDate: startDate, endDate: endDate).request()
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
                    print(self.apodList)
                })
            .store(in: &cancellable)
    }
    
    func fetchAPODDate(at date: String) {
        
        let request = Endpoint.date(date: date).request()
        
        nasaNetwork.fetchAPOD(request: request)
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
                    self.apod = response
                })
            .store(in: &cancellable)
    }
    
    
}
