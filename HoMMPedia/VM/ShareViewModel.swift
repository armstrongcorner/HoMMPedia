//
//  ShareViewModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 18/01/2025.
//

import Foundation
import SwiftUI

private struct ShareViewModelKey: @preconcurrency EnvironmentKey {
    @MainActor
    static let defaultValue: ShareViewModelProtocol = ShareViewModel()
}

extension EnvironmentValues {
    var shareViewModel: ShareViewModelProtocol {
        get { self[ShareViewModelKey.self] }
        set { self[ShareViewModelKey.self] = newValue }
    }
}

@MainActor
protocol ShareViewModelProtocol: AnyObject {
    var isShowingMenu: Bool { get set }
    var selectedAllianName: String? { get set }
    var selectedMenuItem: MenuItem { get set }
}

@Observable @MainActor
final class ShareViewModel: ShareViewModelProtocol {
    var isShowingMenu: Bool
    var selectedAllianName: String?
    var selectedMenuItem: MenuItem
    
    init(
        isShowingMenu: Bool = false,
        selectedAllianName: String? = nil,
        selectedMenuItem: MenuItem = .allian
    ) {
        self.isShowingMenu = isShowingMenu
        self.selectedAllianName = selectedAllianName
        self.selectedMenuItem = selectedMenuItem
    }
}
