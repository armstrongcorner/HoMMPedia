//
//  BaseViewModel.swift
//  HoMMPedia
//
//  Created by Armstrong Liu on 13/01/2025.
//

import Foundation

enum FetchDataState {
    case idle
    case loading
    case success
    case error
}

@MainActor
class BaseViewModel {
    var fetchDataState: FetchDataState
    var errorMessage: String?
    var fileService: FileServiceProtocol
    
    init(
        fetchDataState: FetchDataState = .idle,
        errorMessage: String? = nil,
        fileService: FileServiceProtocol = FileService()
    ) {
        self.fetchDataState = fetchDataState
        self.errorMessage = errorMessage
        
        self.fileService = fileService
    }
    
    func fetchData<T: Decodable & Sendable>(filename: String, as type: T.Type) async -> T? {
        fetchDataState = .loading
        errorMessage = nil
        
        do {
            let data = try await fileService.loadJSONFromAssets(named: filename, as: type)
            fetchDataState = .success
            
            return data
        } catch {
            switch error {
            case let FileServiceError.assetNotFound(fileName: filename):
                appendError("Asset not found: \(filename)")
            case let FileServiceError.decodingFailed(error: error):
                appendError("Decoding failed: \(error.localizedDescription)")
            default:
                appendError("Data fetch failed: \(error.localizedDescription)")
            }
            
            return nil
        }
    }
    
    // Combine the err msg
    func appendError(_ message: String) {
        if let existingError = self.errorMessage {
            errorMessage = "\(existingError)\n\n\(message)"
        } else {
            errorMessage = message
        }
    }
}
