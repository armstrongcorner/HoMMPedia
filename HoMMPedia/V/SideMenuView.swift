//
//  SideMenuView.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 17/01/2025.
//

import SwiftUI

struct SideMenuView: View {
//    @Binding var isShowing: Bool
    @Environment(\.shareViewModel) var shareVM: ShareViewModelProtocol
    
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
//                if (isShowing) {
                if (shareVM.isShowingMenu) {
                    Color.black
                        .opacity(0.3)
                        .onTapGesture {
//                            isShowing.toggle()
                            shareVM.isShowingMenu.toggle()
                        }
                    Text("Side Menu")
                        .transition(edgeTransition)
                        .frame(width: proxy.size.width * (2 / 3), height: proxy.size.height)
                        .background(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//            .animation(.easeInOut, value: isShowing)
            .animation(.easeInOut, value: shareVM.isShowingMenu)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SideMenuView()
        .environment(\.shareViewModel, ShareViewModel(isShowingMenu: true))
}
