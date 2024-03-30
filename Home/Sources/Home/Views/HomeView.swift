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
            CharacterListView(items: viewModel.characters)
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {

    HomeView()
}
