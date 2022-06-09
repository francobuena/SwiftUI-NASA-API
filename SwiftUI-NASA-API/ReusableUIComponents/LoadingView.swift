//
//  LoadingView.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 9/6/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.5)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(3)
        }
    }
}
