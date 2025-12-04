//
//  SwiftUIView.swift
//  Presentation
//
//  Created by 김호성 on 2025.11.27.
//

import SwiftUI
import Domain

public struct CatAdoptView: View {
    
    @EnvironmentObject var catAdoptStore: StoreOf<CatAdoptReducer>
    
    public var body: some View {
        catAdoptInputView
    }
    
    private var catAdoptInputView: some View {
        HStack {
            TextField(
                "입양할 고양이의 수를 입력하세요.",
                value: Binding(
                    get: {
                        catAdoptStore.state.adoptCount
                    },
                    set: {
                        catAdoptStore.send(.adoptCountChanged($0))
                    }
                ),
                format: .number
            )
            .keyboardType(.numberPad)
            Button("입양", action: {
                catAdoptStore.send(.adoptButtonTapped)
            })
        }
    }
}

#Preview {
    CatAdoptView()
        .environmentObject(Store(initialState: CatAdoptReducer.State(), reducer: CatAdoptReducer()))
}
