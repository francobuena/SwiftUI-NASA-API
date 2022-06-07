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
        ZStack {
            VStack(alignment: .center) {
                List {
                    apodList
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.fetchAPODList()
        }
//        .onTapGesture {
//            flipCard()
//        }
    }
    
    private var apodList: some View {
        ForEach(viewModel.apodList) { apod in
            FrontCardView(apodInfo: apod)
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
