//
//  CreatureScreen.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 11/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreatureScreen: View {
    @Environment(\.router) var router
    
    private let allianName: String
    @State private var currentIndex: Int = 0

    @State private var creatureVM: CreatureViewModelProtocol
    @State private var currentCreatureGrade: String
    @State private var gifs: [String]

    init(
        allianName: String,
        currentCreatureGrade: String = "1",
        creatureVM: CreatureViewModelProtocol = CreatureViewModel()
    ) {
        self.allianName = allianName
        self.creatureVM = creatureVM
        self.currentCreatureGrade = currentCreatureGrade
        self.gifs = []
    }
    
    var body: some View {
        BackgroundView {
            VStack {
                ZStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        Text(creatureVM.creatures.first { $0.grade == "\(currentCreatureGrade)-\(currentIndex)" }?.name ?? "")
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        
                        Spacer()
                    }
                    
                    Menu {
                        ForEach(creatureVM.creatures.filter({ creature in
                            creature.grade.hasSuffix("-0")
                        })) { creature in
                            Button {
                                // Choose creature by grade
                                currentCreatureGrade = "\(creature.grade.first ?? Character(""))"
                                gifs = creatureVM.getCreatureGifs(grade: currentCreatureGrade)
                                
                                currentIndex = 0
                            } label: {
                                Text("\(creature.name)")
                            }
                        }
                    } label: {
                        Image(systemName: "person.3.fill")
                            .padding(.trailing, 30)
                            .padding(.top, 20)
                    }
                }
                
                TabView(selection: $currentIndex) {
                    ForEach(gifs.indices, id: \.self) { index in
                        AnimatedImage(data: NSDataAsset(name: gifs[index])!.data)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 60)
                            .tag(index)
                    }
                }
                .padding([.leading, .trailing], 80)
                .frame(height: 200)
                .tabViewStyle(.page)
                .indexViewStyle( .page(backgroundDisplayMode: .always))
                .onChange(of: currentIndex) { oldValue, newValue in
                    print("\(oldValue) -> \(newValue)")
                    print("gifs: \(gifs)")
                }
                
                Spacer()
                
                Button {
                    router.dismissScreen()
                } label: {
                    Text("Go back")
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear() {
            Task {
                await creatureVM.getCreatures(allian: allianName)
                gifs = creatureVM.getCreatureGifs(grade: currentCreatureGrade)
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.primary)
    }
    
}

#Preview {
    CreatureScreen(allianName: "Castle")
}
