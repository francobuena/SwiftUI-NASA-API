//
//  BackCardView.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 2/6/2022.
//

import SwiftUI

struct BackCardView: View {
    
    @StateObject var viewModel = APODViewModel()
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(1))
                .frame(width: 400, height: 400, alignment: .center)
                .border(.gray)
            
            VStack(alignment: .leading) {
                ScrollView {
                    Text(viewModel.apod?.explanation ?? "Long ass explanation here")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                }.padding(.vertical, 10)
            }
            .frame(width: 400, height: 400, alignment: .center)
            .border(.gray)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        .onAppear {
            viewModel.fetchAPOD()
        }
    }
}
