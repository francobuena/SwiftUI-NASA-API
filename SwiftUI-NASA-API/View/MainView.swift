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
    let durationAndDelay : CGFloat = 0.5
    
    // MARK: View body
    var body: some View {
        ZStack {
            FrontCardView(degree: $frontDegree)
            BackCardView(degree: $backDegree)
        }.onTapGesture {
            flipCard()
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

