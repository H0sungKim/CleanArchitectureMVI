//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.06.
//

import Foundation

public struct AnyReducer<State, Action>: Reducer {
    private let _reduce: (inout State, Action) -> Effect<Action>
    
    init<R: Reducer<State, Action>>(_ reducer: R) {
        _reduce = reducer.reduce
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        _reduce(&state, action)
    }
}
