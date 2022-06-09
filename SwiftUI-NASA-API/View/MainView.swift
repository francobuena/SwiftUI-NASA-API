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
                ScrollView {
                    apodList
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
    
    private var apodList: some View {
        // add id here to identify individual cells
        ForEach(viewModel.apodList) { apod in
            FlippableCardView(apodInfo: apod)
        }
    }
}

