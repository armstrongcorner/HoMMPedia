//
//  CreatureModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 12/01/2025.
//

struct CreatureModel: Codable, Sendable {
    let creatures: [Creature]
}

struct Creature:Identifiable, Codable, Sendable {
    let id: Int
    let grade: String
    let name: String
    let belong: String
    let desc: String
    let descCn: String
    let skills: String
    let skillsCn: String
    let image: String
    let creatureAttrs: CreatureAttrs
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case grade = "grade"
        case name = "name"
        case belong = "belong"
        case desc = "desc"
        case descCn = "desc_cn"
        case skills = "skills"
        case skillsCn = "skills_cn"
        case image = "image"
        case creatureAttrs = "attrs"
    }
}

struct CreatureAttrs: Codable, Sendable {
    let health: String
    let attack: String
    let defence: String
    let damage: String
    let speed: String
    let growth: String
    let price: String
    let shots: String
    let size: String
    let movement: String
}
