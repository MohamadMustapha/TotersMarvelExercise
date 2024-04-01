//
//  DetailsView.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Shared
import SwiftUI

public struct DetailsView: View {

    @Environment(\.dismiss) private var dismiss: DismissAction

    @StateObject private var viewModel: DetailsViewModel = .init()

    private let characterId: Int

    public init(characterId: Int) {
        self.characterId = characterId
    }

    public var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ZStack {
                    VStack {
                        Spacer()
                        ProgressView()
                            .controlSize(.large)
                        Spacer()
                    }
                    backButton
                }
            case .loaded(let data):
                GeometryReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            DetailsHeaderView(item: data.character)
                            DetailsCarouselView(carouselType: .comics(data.comics),
                                                      screenWidth: proxy.size.width)
                                .isHidden(data.comics.isEmpty, remove: data.comics.isEmpty)
                            DetailsCarouselView(carouselType: .events(data.events),
                                                      screenWidth: proxy.size.width)
                                .isHidden(data.events.isEmpty, remove: data.events.isEmpty)
                            DetailsCarouselView(carouselType: .stories(data.stories),
                                                      screenWidth: proxy.size.width)
                                .isHidden(data.stories.isEmpty, remove: data.stories.isEmpty)
                            DetailsCarouselView(carouselType: .series(data.series),
                                                      screenWidth: proxy.size.width)
                                .isHidden(data.series.isEmpty, remove: data.series.isEmpty)
                        }
                    }
                    .padding(.bottom, 20)
                    .ignoresSafeArea()
                    .scrollIfNeeded(axes: .vertical)
                }

            case .error:
                ErrorView {
                    Task {
                        await viewModel.onAppear(characterId:characterId)
                    }
                }
            }
        }
        .task {
            await viewModel.onAppear(characterId: characterId)
        }
    }

    @ViewBuilder
    private var backButton: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.gray)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 50)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {

    DetailsView(characterId: 1009268)
}
