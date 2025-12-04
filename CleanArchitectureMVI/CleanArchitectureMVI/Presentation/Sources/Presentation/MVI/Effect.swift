//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.01.
//

import Foundation
@preconcurrency import Combine

public enum Effect<Action>: Sendable {
    case none
    case publisher(AnyPublisher<Action, Never>)
    case run(@Sendable (_ send: @MainActor @escaping @Sendable (Action) -> Void) async throws -> Void)
}
