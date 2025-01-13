//
//  HoMMPediaApp.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 09/01/2025.
//

import SwiftUI
import SwiftfulRouting

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}

@main
struct HoMMPediaApp: App {
    @AppStorage(CacheKey.currentLanguage.rawValue) var selectedLanguageCode = "en"
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                RouterView { _ in
                    AllianScreen()
                        .environment(\.mainWindowSize, proxy.size)
                        .environment(\.locale, .init(identifier: selectedLanguageCode))
                }
            }
        }
    }
}
