//
//  CreatureAttrView.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 14/01/2025.
//

import SwiftUI

struct CreatureAttrView: View {
//    @State var creatureAttrs: CreatureAttrs?
    let creatureAttrs: CreatureAttrs?
    
    var body: some View {
        VStack {
            // Health
            HStack(alignment: .center) {
                Text("Health: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.health ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Attack
            HStack(alignment: .center) {
                Text("Attack: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.attack ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Defence
            HStack(alignment: .center) {
                Text("Defence: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.defence ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Damage
            HStack(alignment: .center) {
                Text("Damage: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.damage ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Speed
            HStack(alignment: .center) {
                Text("Speed: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.speed ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Growth
            HStack(alignment: .center) {
                Text("Growth: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.growth ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Price
            HStack(alignment: .center) {
                Text("Price: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.price ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Shots
            HStack(alignment: .center) {
                Text("Shots: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.shots ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
            // Size
            HStack(alignment: .center) {
                Text("Size: ")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .trailing)
                
                Text(creatureAttrs?.size ?? "")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
                    .frame(width: 150, alignment: .leading)
                
            }
            
//            // Movement
//            HStack(alignment: .center) {
//                Text("Movement: ")
//                    .font(.title3)
//                    .foregroundStyle(.primary)
//                    .fontWeight(.bold)
//                    .frame(width: 150, alignment: .trailing)
//                
//                Text(creatureAttrs?.movement ?? "")
//                    .font(.title3)
//                    .foregroundStyle(.primary)
//                    .fontWeight(.regular)
//                    .frame(width: 150, alignment: .leading)
//                
//            }
        }
    }
}

#Preview {
    let attr = CreatureAttrs(health: "100", attack: "10", defence: "10", damage: "10-20", speed: "10", growth: "1", price: "1000", shots: "10", size: "M", movement: "5")
    CreatureAttrView(creatureAttrs: attr)
}
