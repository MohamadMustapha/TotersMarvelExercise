//
//  HomeView.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Nuke
import Shared
import SwiftUI

public struct HomeView: View {

    @Environment(\.appDataCache) private var appDataCache: DataCache?

    @StateObject private var viewModel: HomeViewModel = .init()

    private let columns: [GridItem] = [.init(.flexible(), spacing: 20, alignment: .top),
                                       .init(.flexible(), spacing: 20, alignment: .top)]

    public init() { }

    public var body: some View {
        NavigationView {
            switch viewModel.uiState {

            case .loading:
                withAnimation {
                    LottieLoaderView(animation: .thor)
                }
            case .loaded(let characters):
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(characters, id: \.id) { item in
                            NavigationLink {
                                DetailsView(characterId: item.id)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                CharacterListCardView(item: item)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationTitle("Marvel")
                .scrollIfNeeded(axes: .vertical)
                .padding(.horizontal)
            case .error:
                ErrorView {
                    Task {
                        await viewModel.onAppear(dataCache: appDataCache)
                    }
                }
            }
        }
        .task {
            await viewModel.onAppear(dataCache: appDataCache)
        }
    }
}

#Preview {

    HomeView()
}
