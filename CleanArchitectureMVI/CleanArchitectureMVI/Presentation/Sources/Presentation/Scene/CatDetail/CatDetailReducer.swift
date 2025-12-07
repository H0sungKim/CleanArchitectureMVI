//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.03.
//

import Domain

import Foundation

public final class CatDetailReducer: Reducer {
    
    public struct State {
        var catEntity: CatEntity
    }
    
    public enum Action {
        
    }
    
    public init() {
        
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
    }
}
