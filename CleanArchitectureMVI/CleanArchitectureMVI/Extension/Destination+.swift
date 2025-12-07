//
//  Destination+.swift
//  CleanArchitectureMVI
//
//  Created by 김호성 on 2025.12.05.
//

import Presentation

import SwiftUI

extension Destination {
    @ViewBuilder
    func build(di: DIContainer) -> some View {
        switch self {
        case .catList:
            CatListView(catUseCase: di.buildCatUseCase())
        case .catDetail(let catEntity):
            CatDetailView(catEntity: catEntity)
        }
    }
}
