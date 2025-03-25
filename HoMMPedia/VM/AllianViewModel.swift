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
    
    func getAllians() async
}

@Observable @MainActor
final class AllianViewModel: BaseViewModel, AllianViewModelProtocol {
    var allians: [Allian]
    
    init(
        fetchDataState: FetchDataState = .idle,
        errorMessage: String? = nil,
        allians: [Allian] = [],
        fileService: FileServiceProtocol = FileService()
    ) {
        self.allians = allians
        
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
}
