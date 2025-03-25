//
//  HomeScreen.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 17/01/2025.
//

import SwiftUI
import SwiftfulRouting

enum MenuItem {
    case allian
    case creature
    case hero
}

struct HomeScreen: View {
    @Environment(\.shareViewModel) var shareVM: ShareViewModelProtocol

    var body: some View {
        RouterView(addNavigationView: true) { router in
            ZStack {
                BackgroundView {
                    TabView(selection: Binding(
                        get: { shareVM.selectedMenuItem },
                        set: { newValue in
                            shareVM.selectedMenuItem = newValue
                        }
                    )) {
                        AllianScreen()
                            .tag(MenuItem.allian)
                        CreatureScreen()
                            .tag(MenuItem.creature)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                
                SideMenuView()
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        HomeScreen()
            .environment(\.mainWindowSize, proxy.size)
            .environment(\.locale, .init(identifier: "zh"))
            .environment(\.shareViewModel, ShareViewModel(isShowingMenu: true, selectedMenuItem: .allian))
    }
}
