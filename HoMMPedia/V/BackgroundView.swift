//
//  BackgroundView.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 10/01/2025.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    @Environment(\.mainWindowSize) var mainSize: CGSize
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
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
                        .frame(width: mainSize.width)
                    
                    // Middle img
                    Image("bg_middle")
                        .resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .stretch)
                        .frame(width: mainSize.width)
                    
                    // Bottom img
                    Image("bg_bottom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: mainSize.width)
                }
                
                // Content
                content
            }
    }
}

#Preview {
    GeometryReader { proxy in
        BackgroundView {
            Text("Hello, World!")
        }
        .environment(\.mainWindowSize, proxy.size)
    }
}
