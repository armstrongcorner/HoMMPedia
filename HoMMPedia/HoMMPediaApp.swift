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
    @AppStorage(CacheKey.currentLanguage.rawValue) var selectedLanguageCode = "zh"
    @State private var shareVM: ShareViewModelProtocol
    
    init() {
        self.shareVM = ShareViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
//                AllianScreen()
//                    .environment(\.mainWindowSize, proxy.size)
//                    .environment(\.locale, .init(identifier: selectedLanguageCode))
//                    .environment(\.shareViewModel, shareVM)
                HomeScreen()
                    .environment(\.mainWindowSize, proxy.size)
                    .environment(\.locale, .init(identifier: selectedLanguageCode))
                    .environment(\.shareViewModel, shareVM)
            }
        }
    }
}
