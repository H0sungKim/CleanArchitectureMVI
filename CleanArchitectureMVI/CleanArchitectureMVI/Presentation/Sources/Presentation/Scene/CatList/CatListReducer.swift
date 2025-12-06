//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.03.
//

import Domain

import Combine
import Foundation

public final class CatListReducer: Reducer {
    
    public struct State {
        var adoptCount: Int?
        var adoptedCats: [CatEntity] = []
        var adoptLoading: Bool = false
    }
    
    public enum Action {
        case adoptCountChanged(Int?)
        case adoptButtonTapped
        case catsFetched([CatEntity])
        case releaseCat(CatEntity)
    }
    
    private let catUseCase: CatUseCase
    
    public init(catUseCase: CatUseCase) {
        self.catUseCase = catUseCase
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .adoptCountChanged(let adoptCount):
            state.adoptCount = adoptCount
            return .none
            
        case .adoptButtonTapped:
            guard let adoptCount = state.adoptCount else {
                return .none
            }
            state.adoptLoading = true
            return .publisher(
                catUseCase
                    .fetchCats(count: adoptCount)
                    .map({ Action.catsFetched($0) })
                    .catch({ error in
                        Log.e(error.localizedDescription)
                        return Just(Action.catsFetched([]))
                    })
                    .eraseToAnyPublisher()
            )
            
        case .catsFetched(let catEntities):
            state.adoptLoading = false
            state.adoptedCats.append(contentsOf: catEntities)
            return .none
            
        case .releaseCat(let catEntity):
            state.adoptedCats.removeAll(where: { $0 == catEntity })
            return .none
            
        }
    }
}
