//
//  HomeView.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel = .init()

    var body: some View {
        NavigationView {
            switch viewModel.uiState {

            case .loading:
                ProgressView()
                    .controlSize(.large)
            case .loaded(let marvelCharacters):
                CharacterListView(items: marvelCharacters)
                    .navigationTitle(.init("Marvel"))
            case .error:
                #warning("Do error view")
                EmptyView()
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {

    HomeView()
}
