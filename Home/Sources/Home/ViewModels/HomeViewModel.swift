//
//  HomeViewModel.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Shared
import SwiftUI

class HomeViewModel: ObservableObject {

    enum UIState {

        case loading, loaded(marvelCharacters: [CharacterModel]), error
    }

    @Published private(set) var uiState: UIState = .loading

    private let homeService: HomeService = HomeServiceImpl(charactersApi: HttpCharactersApi())

    init() {}

    func onAppear() async {
        do {
            let marvelCharacters: [CharacterModel] = try await homeService.getCharacters().get()
            withAnimation {
                self.uiState = .loaded(marvelCharacters: marvelCharacters)
            }
        } catch {
            print("Could not retrieve characters from service with error: \(error.localizedDescription)")
            self.uiState = .error
        }
    }
}
