//
//  AllianScreen.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 09/01/2025.
//

import SwiftUI
import SwiftfulRouting

struct AllianScreen: View {
    @Environment(\.mainWindowSize) var mainSize: CGSize
    @Environment(\.locale) var locale
    @Environment(\.shareViewModel) var shareVM: ShareViewModelProtocol
    
    @State private var allianVM: AllianViewModelProtocol
    
    init(allianVM: AllianViewModelProtocol = AllianViewModel()) {
        self.allianVM = allianVM
    }
    
    var body: some View {
        let itemWidth: CGFloat = (mainSize.width - 20.0*3) / 2.0
        let itemHeight: CGFloat = itemWidth / (150.0 / 70.0)
        
        let gridColumns: [GridItem] = [
            GridItem(.fixed(itemWidth), spacing: 10),
            GridItem(.fixed(itemWidth), spacing: 10)
        ]
        
        VStack {
            Text("Choose Allian")
                .font(.title)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
                .padding(.top, 20)
            
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 10) {
                    ForEach(allianVM.allians) { allian in
                        VStack {
                            Rectangle()
                                .frame(height: itemHeight)
                                .overlay(
                                    Image(allian.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                )
                                .clipped()
                                .cornerRadius(5)
                            
                            Text(locale.identifier == "zh" ? allian.nameCn : allian.name)
                                .font(.body)
                                .foregroundStyle(.primary)
                                .fontWeight(.semibold)
                        }
                        .onTapGesture {
                            shareVM.selectedMenuItem = .creature
                            shareVM.selectedAllianName = allian.name
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .onAppear() {
            Task {
                await allianVM.getAllians()
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        AllianScreen()
            .environment(\.mainWindowSize, proxy.size)
            .environment(\.locale, .init(identifier: "zh"))
    }
}
