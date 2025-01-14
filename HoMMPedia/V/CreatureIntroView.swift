//
//  CreatureIntroView.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 14/01/2025.
//

import SwiftUI

struct CreatureIntroView: View {
    @Environment(\.locale) var locale
    
    let currentCreature: Creature?
    
    var body: some View {
        VStack {
            // Skills
            if currentCreature?.skills ?? "" != "" {
                HStack(alignment: .top) {
                    Text("Skills: ")
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                        .frame(width: 170, alignment: .trailing)
                    
                    Text(locale.identifier == "zh" ? currentCreature?.skillsCn ?? "" : currentCreature?.skills ?? "")
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .fontWeight(.regular)
                        .frame(width: 170, alignment: .leading)
                }
                .padding(.bottom, 5)
            }
            
            // Intro
            Text(locale.identifier == "zh" ? currentCreature?.descCn ?? "" : currentCreature?.desc ?? "")
                .font(.title3)
                .foregroundStyle(.primary)
                .fontWeight(.regular)
                .padding([.leading, .trailing], 25)
        }
    }
}

#Preview("with skills") {
    let creature = Creature(id: 1, grade: "1", name: "Test", belong: "Test", desc: "As the 1st level castle unit, the strength of the Pikeman and Halberdier soldiers is really not comparable to the peasants in the previous HoMM. Their fairly balanced attack and defense capabilities make them able to compete with the strongest Centaur Captain in the other 1st level units. The only regret is that their speed is slightly lower, so if they encounter long-range troops in the initial battle, they will be in a difficult battle. The upgraded Halberdier soldiers' attack and damage are increased, and their strength is obviously enhanced.", descCn: "同样都是人类族的一级兵种，枪兵和戟兵的实力跟前作中的农民却实在无法搭脉。相当平衡的攻防能力值使他们足以和另一个一级兵种中能力最强的半人马队长一较长短。唯一遗憾的是速度略低，这样在开局的战斗中如果遇上远程部队的话会陷入苦战。升级后的戟兵的攻击和伤害都增加了，实力明显增强了不少。", skills: "Immune to jousting", skillsCn: "骑兵的冲锋无效", image: "Test", creatureAttrs: CreatureAttrs(health: "100", attack: "10", defence: "10", damage: "10-20", speed: "10", growth: "1", price: "1000", shots: "10", size: "M", movement: "5"))
    
    CreatureIntroView(currentCreature: creature)
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("without skills") {
    let creature = Creature(id: 1, grade: "1", name: "Test", belong: "Test", desc: "As the 1st level castle unit, the strength of the Pikeman and Halberdier soldiers is really not comparable to the peasants in the previous HoMM. Their fairly balanced attack and defense capabilities make them able to compete with the strongest Centaur Captain in the other 1st level units. The only regret is that their speed is slightly lower, so if they encounter long-range troops in the initial battle, they will be in a difficult battle. The upgraded Halberdier soldiers' attack and damage are increased, and their strength is obviously enhanced.", descCn: "同样都是人类族的一级兵种，枪兵和戟兵的实力跟前作中的农民却实在无法搭脉。相当平衡的攻防能力值使他们足以和另一个一级兵种中能力最强的半人马队长一较长短。唯一遗憾的是速度略低，这样在开局的战斗中如果遇上远程部队的话会陷入苦战。升级后的戟兵的攻击和伤害都增加了，实力明显增强了不少。", skills: "", skillsCn: "", image: "Test", creatureAttrs: CreatureAttrs(health: "100", attack: "10", defence: "10", damage: "10-20", speed: "10", growth: "1", price: "1000", shots: "10", size: "M", movement: "5"))
    
    CreatureIntroView(currentCreature: creature)
        .environment(\.locale, .init(identifier: "en"))
}
