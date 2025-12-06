//
//  RootView.swift
//  CleanArchitectureMVI
//
//  Created by 김호성 on 2025.12.04.
//

import Presentation

import SwiftUI

struct RootView: View {
    
    @StateObject private var appCoordinator = AppCoordinator(root: .catList)
    private let diContainer = DIContainer()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path, root: {
            appCoordinator.root.build(di: diContainer)
                .navigationDestination(for: Destination.self, destination: { $0.build(di: diContainer) })
        })
        .environmentObject(appCoordinator)
    }
}

#Preview {
    RootView()
}
