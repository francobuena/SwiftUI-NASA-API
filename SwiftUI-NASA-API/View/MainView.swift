//
//  ContentView.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 22/5/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    // MARK: Properties
    @StateObject var viewModel = APODViewModel()
    
    // MARK: View body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Picker("Request type", selection: $viewModel.currentRequest) {
                            ForEach(RequestType.allCases, id: \.self) {
                                Text($0.description)
                            }
                        }
                        .onChange(of: viewModel.currentRequest) { newValue in
                            viewModel.fetchAPODList()
                        }
                        .padding(.leading, 20)
                        .pickerStyle(.menu)
                        
                        Spacer()
                    }
                    
                    ScrollView {
                        cardList
                    }
                }
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("APOD")
            .onAppear {
                viewModel.fetchAPODList()
            }
            .alert("An error occured", isPresented: $viewModel.showAlert) {
                Button("OK") {
                }
            } message: {
                Text(viewModel.errorText)
            }
        }
    }
    
    private var cardList: some View {
        ForEach(viewModel.apodList) { apod in
            FlippableCardView(apodInfo: apod)
        }
    }
}
