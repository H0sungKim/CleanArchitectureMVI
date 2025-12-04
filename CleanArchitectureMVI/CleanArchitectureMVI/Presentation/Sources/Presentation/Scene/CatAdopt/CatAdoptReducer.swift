//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.03.
//

import Domain

import Foundation

final class CatAdoptReducer: Reducer {
    
    private let catUseCase: CatUseCase
    
    struct State {
        var adoptCount: Int?
        var adoptedCats: [CatEntity] = []
    }
    
    enum Action {
        case adoptCountChanged(Int?)
        case adoptButtonTapped
        
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .adoptCountChanged(let adoptCount):
            state.adoptCount = adoptCount
            return .none
        case .adoptButtonTapped:
            Log.d(state.adoptCount, method: .print)
            return .none
        }
    }
}
