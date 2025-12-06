//
//  CatFactory.swift
//  CleanArchitectureMVI
//
//  Created by 김호성 on 2025.12.05.
//

import Data
import Domain
import Presentation

import Foundation

protocol CatFactory {
    func buildCatRepository() -> CatRepository
    func buildCatRepository(catService: CatService) -> CatRepository
    
    func buildCatUseCase() -> CatUseCase
    func buildCatUseCase(catRepository: CatRepository) -> CatUseCase
}

extension CatFactory {
    func buildCatRepository(catService: CatService) -> CatRepository {
        return DefaultCatRepository(catService: catService)
    }
    
    func buildCatUseCase() -> CatUseCase {
        return DefaultCatUseCase(catRepository: buildCatRepository())
    }
    func buildCatUseCase(catRepository: CatRepository) -> CatUseCase {
        return DefaultCatUseCase(catRepository: catRepository)
    }
}
