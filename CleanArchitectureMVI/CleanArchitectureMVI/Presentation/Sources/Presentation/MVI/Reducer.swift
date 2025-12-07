//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.11.29.
//

public protocol Reducer<State, Action> {
    
    associatedtype State
    associatedtype Action
    
    func reduce(into state: inout State, action: Action) -> Effect<Action>
}
