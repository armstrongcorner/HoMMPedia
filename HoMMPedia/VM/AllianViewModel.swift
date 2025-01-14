//
//  AllianViewModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 09/01/2025.
//

import Foundation

@MainActor
protocol AllianViewModelProtocol {
    var fetchDataState: FetchDataState { get }
    var errorMessage: String? { get }
    
    var allians: [Allian] { get }
    var creatures: [Creature] { get }
    
    func getAllians() async
    func getCreatures(allian: String) async
}

@Observable @MainActor
final class AllianViewModel: BaseViewModel, AllianViewModelProtocol {
    var allians: [Allian]
    var creatures: [Creature]
    
    init(
        fetchDataState: FetchDataState = .idle,
        errorMessage: String? = nil,
        allians: [Allian] = [],
        creatures: [Creature] = [],
        fileService: FileServiceProtocol = FileService()
    ) {
        self.allians = allians
        self.creatures = creatures
        
        super.init(
            fetchDataState: fetchDataState,
            errorMessage: errorMessage,
            fileService: fileService
        )
    }
    
    func getAllians() async {
        if let allianModel = await fetchData(filename: "allians", as: AllianModel.self) {
            self.allians = allianModel.allians
            print("total allians: \(allians.count)")
        }
    }
    
    func getCreatures(allian: String) async {
        let filename = "\(allian.lowercased())_creatures"
        
        if let creatureModel = await fetchData(filename: filename, as: CreatureModel.self) {
            self.creatures = creatureModel.creatures
            print("\(allian) total creatures: \(creatures.count)")
        }
    }
}
