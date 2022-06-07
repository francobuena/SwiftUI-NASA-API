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
    var apodInfo: APOD
    @Binding var degree: Double
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(1))
                .border(.gray)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(apodInfo.title ?? "No title")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .layoutPriority(1)
                    Text(apodInfo.date ?? "XXXX/XX/XX")
                        .font(.subheadline)
                    apodInfo.copyright.map({
                        Text("© \($0)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    })
                }
                .padding([.leading, .trailing], 16)
                
                HStack {
                    Spacer()
                    WebImage(url: URL(string: apodInfo.imageURL ?? "https://images.app.goo.gl/rADoLKwtth13Msp66"))
                        .resizable()
                        .transition(.fade(duration: 0.5))
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                    .padding(8.0)
                    Spacer()
                }
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
    
    private var apodList: some View {
        ForEach(viewModel.apodList) { apod in
            FrontCardRow(apodInfo: apod)
        }
    }
    
}
