//
//  CreatureScreen.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 11/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreatureScreen: View {
    @Environment(\.mainWindowSize) var mainSize: CGSize
    @Environment(\.router) var router
    @Environment(\.locale) var locale
    
    private let allianName: String
    @State private var currentIndex: Int = 0

    @State private var creatureVM: CreatureViewModelProtocol
    @State private var currentCreatureGrade: String
    @State private var currentCreature: Creature?
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
                // Header and creature choose
                ZStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
//                        Text(creatureVM.creatures.first { $0.grade == "\(currentCreatureGrade)-\(currentIndex)" }?.name ?? "")
//                            .font(.title2)
//                            .foregroundStyle(.primary)
//                            .fontWeight(.semibold)
//                            .padding(.top, 20)
                        Text(currentCreature?.name ?? "")
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
                                currentCreature = creatureVM.getCurrentCreature(grade: "\(currentCreatureGrade)-\(currentIndex)")
                                
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
                
                ScrollView {
                    // Switching same grade
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
                        currentCreature = creatureVM.getCurrentCreature(grade: "\(currentCreatureGrade)-\(currentIndex)")
                        print("current creature: \(currentCreature?.name ?? "")")
                    }
                    
                    // Attributes
                    CreatureAttrView(creatureAttrs: currentCreature?.creatureAttrs)
                        .padding(.bottom, 5)
                    
                    // Skills & Intro
                    CreatureIntroView(currentCreature: currentCreature)
                        .padding(.bottom, 30)
                    
                    Button {
                        router.dismissScreen()
                    } label: {
                        Text("Go back")
                    }
                    .padding(.bottom, 50)
                }
                .padding(.bottom, 25)
            }
        }
        .onAppear() {
            Task {
                await creatureVM.getCreatures(allian: allianName)
                gifs = creatureVM.getCreatureGifs(grade: currentCreatureGrade)
                currentCreature = creatureVM.getCurrentCreature(grade: "\(currentCreatureGrade)-\(currentIndex)")
                print("current creature: \(currentCreature?.name ?? "")")
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.primary)
    }
}

#Preview {
    CreatureScreen(allianName: "Castle")
        .environment(\.locale, .init(identifier: "zh"))
}
