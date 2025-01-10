//
//  AllianViewModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 09/01/2025.
//

import Foundation

enum FetchDataState {
    case idle
    case loading
    case success
    case error
}

protocol AllianViewModelProtocol: Sendable {
    var fetchDataState: FetchDataState { get }
    var allians: [Allian] { get }
    var errorMessage: String? { get }
    
    func fetchData() async
}

@Observable
final class AllianViewModel: AllianViewModelProtocol {
    var fetchDataState: FetchDataState
    var allians: [Allian]
    var errorMessage: String?
    
    private let fileService: FileServiceProtocol
    
    init(
        fetchDataState: FetchDataState = .idle,
        allians: [Allian] = [],
        errorMessage: String? = nil,
        fileService: FileServiceProtocol = FileService()
    ) {
        self.fetchDataState = fetchDataState
        self.allians = allians
        self.errorMessage = errorMessage
        
        self.fileService = fileService
    }
    
    func fetchData() async {
        fetchDataState = .loading
        
        let fileName = "allians"
        do {
            let allianModel = try await fileService.loadJSONFromAssets(named: fileName, as: AllianModel?.self)
            self.allians = allianModel?.allians ?? []
            print("total allians: \(allians.count)")
            
            fetchDataState = .success
        } catch {
            switch error {
            case let FileServiceError.assetNotFound(fileName: fileName):
                appendError("Asset not found: \(fileName)")
            case let FileServiceError.decodingFailed(error: error):
                appendError("Decoding failed: \(error.localizedDescription)")
            default:
                appendError("Data fetch failed: \(error.localizedDescription)")
            }
        }
    }
    
    // Combine the err msg
    private func appendError(_ message: String) {
        if let existingError = self.errorMessage {
            errorMessage = "\(existingError)\n\n\(message)"
        } else {
            errorMessage = message
        }
    }
}
