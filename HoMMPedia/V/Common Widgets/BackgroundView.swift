//
//  BackgroundView.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 10/01/2025.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Out of safe area
                Color.bg
                    .edgesIgnoringSafeArea(.all)
                
                // Background
                VStack(spacing: 0) {
                    // Top img
                    Image("bg_top")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width)
                    
                    // Middle img
                    Image("bg_middle")
                        .resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .stretch)
                        .frame(width: proxy.size.width)
                    
                    // Bottom img
                    Image("bg_bottom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width)
                }
                
                // Content
                content
            }
        }
    }
}

#Preview {
    BackgroundView {
        Text("Hello, World!")
    }
}
