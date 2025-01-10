//
//  HoMMPediaApp.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 09/01/2025.
//

import SwiftUI

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
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                AllianView()
                    .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}
