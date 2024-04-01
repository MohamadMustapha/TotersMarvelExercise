//
//  HomeView.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Details
import Shared
import SwiftUI

public struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel = .init()

    private let columns: [GridItem] = [.init(.flexible(), spacing: 20, alignment: .top),
                                       .init(.flexible(), spacing: 20, alignment: .top)]

    public init() { }

    public var body: some View {
        NavigationView {
            switch viewModel.uiState {

            case .loading:
                ProgressView()
                    .controlSize(.large)
            case .loaded(let characters):
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(characters, id: \.id) { item in
                            NavigationLink {
                                DetailsView(characterId: item.id)
                            } label: {
                                CharacterListCardView(item: item)
                            }
                        }
                        // TODO: change to custom styling
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationTitle("Marvel")
                .scrollIfNeeded(axes: .vertical)
                .padding(.horizontal)
            case .error:
                ErrorView {
                    Task {
                        await viewModel.onAppear()
                    }
                }
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
