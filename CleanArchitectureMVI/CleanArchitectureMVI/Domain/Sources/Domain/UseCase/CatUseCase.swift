//
//  CatUseCase.swift
//  Domain
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

public protocol CatUseCase {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error>
}

public final class DefaultCatUseCase: CatUseCase {
    private let catRepository: CatRepository
    
    public init(catRepository: CatRepository) {
        self.catRepository = catRepository
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error> {
        return catRepository.fetchCats(count: count)
    }
}
