//
//  CreatureViewModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 13/01/2025.
//

import Foundation

@MainActor
protocol CreatureViewModelProtocol {
    var fetchDataState: FetchDataState { get }
    var errorMessage: String? { get }
    
    var creatures: [Creature] { get }
    
    func getCreatures(allian: String) async
    func getCreatureGifs(grade: String) -> [String]
}

@Observable @MainActor
final class CreatureViewModel: BaseViewModel, CreatureViewModelProtocol {
    var creatures: [Creature]
    
    init(
        fetchDataState: FetchDataState = .idle,
        errorMessage: String? = nil,
        fileService: FileServiceProtocol = FileService(),
        creatures: [Creature] = []
    ) {
        self.creatures = creatures
        
        super.init(
            fetchDataState: fetchDataState,
            errorMessage: errorMessage,
            fileService: fileService
        )
    }
    
    func getCreatures(allian: String) async {
        let filename = "\(allian.lowercased())_creatures"
        
        if let creatureModel = await fetchData(filename: filename, as: CreatureModel.self) {
            self.creatures = creatureModel.creatures
            print("\(allian) total creatures: \(creatures.count)")
        }
    }
    
    func getCreatureGifs(grade: String) -> [String] {
        let gifs = creatures.filter { creature in
            return creature.grade.starts(with: "\(grade)-")
        }.map { creature in
            creature.image
        }
        
        return gifs
    }
}
