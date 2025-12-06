//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.02.
//

import Domain

import Foundation
import Combine

@MainActor
public final class Store<State, Action>: ObservableObject {
    
    private let reducer: any Reducer<State, Action>
    private var cancellables: Set<AnyCancellable> = []
    
    @Published public private(set) var state: State
    
    public init<R: Reducer<State, Action>>(reducer: R, initialState: State) {
        self.reducer = reducer
        state = initialState
    }
    
    public func send(_ action: Action) {
        let effect = reducer.reduce(into: &state, action: action)
        
        switch effect {
        case .none:
            break
        case .publisher(let anyPublisher):
            anyPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] action in
                    self?.send(action)
                })
                .store(in: &cancellables)
        case .run(let operation):
            Task {
                do {
                    try await operation({ [weak self] action in
                        guard let self else { return }
                        self.send(action)
                    })
                } catch {
                    Log.e("Effect.run error:", error.localizedDescription)
                }
            }
        }
    }
}

public typealias StoreOf<R: Reducer> = Store<R.State, R.Action>
