////
////  AllianViewModel.swift
////  HoMMPedia
////
////  Created by Armstrong Liu on 09/01/2025.
////
//
//import Foundation
//
//enum FetchDataState {
//    case idle
//    case loading
//    case success
//    case error
//}
//
//protocol AllianViewModelProtocol: Sendable {
//    var fetchDataState: FetchDataState { get }
//    var errorMessage: String? { get }
//    
//    var allians: [Allian] { get }
//    var creatures: [Creature] { get }
////    func fetchData() async
////    func fetchData<T: Decodable & Sendable>(filename: String, as type: T.Type) async -> T?
//    func getAllians() async
//    func getCreatures(allian: String) async
//}
//
//@Observable
//final class AllianViewModel: AllianViewModelProtocol {
//    var fetchDataState: FetchDataState
//    var errorMessage: String?
//    
//    var allians: [Allian]
//    var creatures: [Creature]
//    
//    private let fileService: FileServiceProtocol
//    
//    init(
//        fetchDataState: FetchDataState = .idle,
//        errorMessage: String? = nil,
//        allians: [Allian] = [],
//        creatures: [Creature] = [],
//        fileService: FileServiceProtocol = FileService()
//    ) {
//        self.fetchDataState = fetchDataState
//        self.errorMessage = errorMessage
//        
//        self.allians = allians
//        self.creatures = creatures
//        
//        self.fileService = fileService
//    }
//    
//    func getAllians() async {
//        if let allianModel = await fetchData(filename: "allians", as: AllianModel.self) {
//            self.allians = allianModel.allians
//            print("total allians: \(allians.count)")
//        }
//    }
//    
//    func getCreatures(allian: String) async {
//        let filename = "\(allian.lowercased())_creatures"
//        
//        if let creatureModel = await fetchData(filename: filename, as: CreatureModel.self) {
//            self.creatures = creatureModel.creatures
//            print("\(allian) total creatures: \(creatures.count)")
//        }
//    }
//    
////    func fetchData() async {
////        fetchDataState = .loading
////        
////        let fileName = "allians"
////        do {
////            let allianModel = try await fileService.loadJSONFromAssets(named: fileName, as: AllianModel?.self)
////            self.allians = allianModel?.allians ?? []
////            print("total allians: \(allians.count)")
////            
////            fetchDataState = .success
////        } catch {
////            switch error {
////            case let FileServiceError.assetNotFound(fileName: fileName):
////                appendError("Asset not found: \(fileName)")
////            case let FileServiceError.decodingFailed(error: error):
////                appendError("Decoding failed: \(error.localizedDescription)")
////            default:
////                appendError("Data fetch failed: \(error.localizedDescription)")
////            }
////        }
////    }
//    
//    private func fetchData<T: Decodable & Sendable>(filename: String, as type: T.Type) async -> T? {
//        fetchDataState = .loading
//        errorMessage = nil
//        
//        do {
//            let data = try await fileService.loadJSONFromAssets(named: filename, as: type)
//            fetchDataState = .success
//            
//            return data
//        } catch {
//            switch error {
//            case let FileServiceError.assetNotFound(fileName: filename):
//                appendError("Asset not found: \(filename)")
//            case let FileServiceError.decodingFailed(error: error):
//                appendError("Decoding failed: \(error.localizedDescription)")
//            default:
//                appendError("Data fetch failed: \(error.localizedDescription)")
//            }
//            
//            return nil
//        }
//    }
//    
//    // Combine the err msg
//    private func appendError(_ message: String) {
//        if let existingError = self.errorMessage {
//            errorMessage = "\(existingError)\n\n\(message)"
//        } else {
//            errorMessage = message
//        }
//    }
//}







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
