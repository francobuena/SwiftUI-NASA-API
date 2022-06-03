//
//  FrontCardView.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 2/6/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FrontCardView: View {
    
    @StateObject var viewModel = APODViewModel()
    @Binding var degree: Double
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                List {
                    apodList
                }
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        .onAppear {
            viewModel.fetchAPODList()
        }
    }
    
    private var apodList: some View {
        ForEach(viewModel.apodList) { apod in
            FrontCardRow(apodInfo: apod)
        }
    }
    
}
