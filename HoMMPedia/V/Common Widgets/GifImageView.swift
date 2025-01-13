//
//  GifImageView.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 12/01/2025.
//

import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        guard let gifDataAsset = NSDataAsset(name: name) else {
            fatalError("Could not load GIF")
        }
        webView.load(gifDataAsset.data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: URL(fileURLWithPath: ""))
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.backgroundColor = .clear
        uiView.reload()
    }
}

#Preview {
    GifImageView("h3_castle_pikeman")
}
