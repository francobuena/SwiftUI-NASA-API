//
//  FrontCardRow.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 3/6/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FrontCardRow: View {
    
    var apodInfo: APOD
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(1))
                .frame(width: 400, height: 400, alignment: .center)
                .border(.gray)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(apodInfo.title ?? "No title")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .fixedSize()
                    Text(apodInfo.date ?? "XXXX/XX/XX")
                        .font(.subheadline)
                    apodInfo.copyright.map({
                        Text("© \($0)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    })
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
                
                WebImage(url: URL(string: apodInfo.imageURL ?? "https://images.app.goo.gl/rADoLKwtth13Msp66"))
                    .resizable()
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 400, height: 300, alignment: .center)
                    .padding(.horizontal)
            }
        }
    }
}

