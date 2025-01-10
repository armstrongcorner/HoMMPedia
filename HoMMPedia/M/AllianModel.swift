//
//  AllianModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 09/01/2025.
//

struct AllianModel: Codable, Sendable {
    let allians: [Allian]
}

struct Allian: Identifiable, Codable, Sendable {
    let id: Int
    let name: String
    let nameCn: String
    let desc: String
    let descCn: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case nameCn = "name_cn"
        case desc = "desc"
        case descCn = "desc_cn"
        case image = "image"
    }
}
