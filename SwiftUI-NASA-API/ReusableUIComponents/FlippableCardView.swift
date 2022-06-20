//
//  FlippableCardView.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 7/6/2022.
//

import SwiftUI

struct FlippableCardView: View {
    
    // MARK: Properties
    @State var frontDegree = 0.0
    @State var backDegree = -90.0
    @State var isFlipped = false
    let durationAndDelay : CGFloat = 0.5
    var apodInfo: APOD
   
    // MARK: View body
    var body: some View {
        ZStack {
            BackCardView(apodInfo: apodInfo, degree: $backDegree)
            FrontCardView(apodInfo: apodInfo, degree: $frontDegree)
        }
        .frame(height: 350)
        .padding([.leading, .trailing], 16)
        .onTapGesture {
            flipCard()
        }
    }
    
    // MARK: Functions
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        }
    }
}
