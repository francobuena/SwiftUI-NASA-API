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
    @State var frontDegree = 0.0
    @State var backDegree = -90.0
    @State var isFlipped = false
    @StateObject var viewModel = APODViewModel()
    let durationAndDelay : CGFloat = 0.5
    
    // MARK: View body
    var body: some View {
        NavigationView {
            ScrollView {
                apodList
            }
            .navigationTitle("APOD")
            .onAppear {
                viewModel.fetchAPODList()
            }
        }
    }
    
    private var apodList: some View {
        // add id here to identify individual cells
        ForEach(viewModel.apodList) { apod in
            ZStack {
                // inject these values inside the individual cards
                //                @State var frontDegree = 0.0
                //                @State var backDegree = -90.0
                //                @State var isFlipped = false
                // merge the two cards in one
                //
                FrontCardView(apodInfo: apod, degree: $frontDegree)
                BackCardView(apodInfo: apod, degree: $backDegree)
            }
            .frame(height: 400)
            .padding([.leading, .trailing], 16)
            .onTapGesture {
                flipCard()
            }
            
        }
    }
    
    // MARK: Functions
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
}

