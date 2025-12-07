//
//  SwiftUIView.swift
//  Presentation
//
//  Created by 김호성 on 2025.11.27.
//

import Domain

import SwiftUI

import Kingfisher

public struct CatListView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var catListStore: StoreOf<CatListReducer>
    
    public init(catListStore: StoreOf<CatListReducer>) {
        _catListStore = StateObject(wrappedValue: catListStore)
    }
    
    public init(catUseCase: CatUseCase) {
        let catListReducer = CatListReducer(catUseCase: catUseCase)
        _catListStore = StateObject(wrappedValue: Store(reducer: AnyReducer(catListReducer), initialState: .init()))
    }
    
    public var body: some View {
        VStack {
            catList
            catAdoptInputView
                .padding(.horizontal, 8)
                .safeAreaPadding(.bottom, 16)
        }
    }
    
    private var catList: some View {
        List(catListStore.state.adoptedCats) { adoptedCat in
            CatRow(catEntity: adoptedCat)
                .onTapGesture {
                    appCoordinator.push(to: .catDetail(adoptedCat))
                }
        }
        .listStyle(.plain)
    }
    
    private var catAdoptInputView: some View {
        HStack {
            TextField(
                "입양할 고양이의 수를 입력하세요.",
                value: Binding(
                    get: {
                        catListStore.state.adoptCount
                    },
                    set: {
                        catListStore.send(.adoptCountChanged($0))
                    }
                ),
                format: .number
            )
            .keyboardType(.numberPad)
            Button("입양", action: {
                catListStore.send(.adoptButtonTapped)
            })
        }
    }
}

private struct CatRow: View {
    var catEntity: CatEntity
    
    var body: some View {
        HStack(alignment: .top) {
            catImage
            catInfoView
        }
    }
    
    private var catImage: some View {
        KFImage(catEntity.imageUrl)
            .resizable()
            .scaledToFill()
            .frame(width: 128, height: 128)
            .clipped()
    }
    
    private var catInfoView: some View {
        VStack(alignment: .leading) {
            Text(catEntity.species)
                .font(.title2)
            Text(catEntity.features)
                .font(.body)
            if let wikipedia = catEntity.wikipedia {
                Link("Wikipedia", destination: wikipedia)
                    .foregroundStyle(.blue)
            }
        }
    }
}


struct CatListView_Preview: PreviewProvider {
    static var previews: some View {
        CatListView(catUseCase: MockCatUseCase())
            .environmentObject(AppCoordinator(root: .catList))
        
        CatRow(catEntity: CatEntity(id: UUID().uuidString, imageUrl: URL(string: "https://lv2-cdn.azureedge.net/jypark/f8ba911ed379439fbe831212be8701f9-231103%206PM%20%EB%B0%95%EC%A7%84%EC%98%81%20Conceptphoto03(Clean).jpg"), size: .zero, species: "냐옹", features: "박진냥이에용~", wikipedia: URL(string: "https://en.wikipedia.org/wiki/J.Y._Park")))
    }
}
