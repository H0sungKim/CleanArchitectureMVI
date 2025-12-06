//
//  DIContainer.swift
//  CleanArchitectureMVI
//
//  Created by 김호성 on 2025.12.05.
//

import Data
import Domain

import Foundation
import Combine

final class DIContainer {
    
    private lazy var catService: CatService = DefaultCatService(apiKey: Bundle.main.apiKey!)
    
    init() {
        
    }
}

extension DIContainer: CatFactory {
    func buildCatRepository() -> CatRepository {
        buildCatRepository(catService: catService)
    }
}
