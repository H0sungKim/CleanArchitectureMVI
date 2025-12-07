//
//  SwiftUIView.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.03.
//

import Domain

import SwiftUI

public struct CatDetailView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var catDetailStore: StoreOf<CatDetailReducer>
    
    public init(catDetailStore: StoreOf<CatDetailReducer>) {
        _catDetailStore = StateObject(wrappedValue: catDetailStore)
    }
    
    public init(catEntity: CatEntity) {
        _catDetailStore = StateObject(wrappedValue: Store(reducer: AnyReducer(CatDetailReducer()), initialState: .init(catEntity: catEntity)))
    }
    
    public var body: some View {
        Text(catDetailStore.state.catEntity.species)
    }
}
