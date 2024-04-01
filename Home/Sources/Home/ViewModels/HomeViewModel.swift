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

        case loading, loaded(characters: [CharacterModel]), error
    }

    @Published private(set) var uiState: UIState = .loading

    private let homeService: HomeService = HomeServiceImpl(charactersApi: HttpCharactersApi())

    init() {}

    func onAppear() async {
        do {
            let characters: [CharacterModel] = try await homeService.getCharacters().get()
            withAnimation {
                self.uiState = .loaded(characters: characters)
            }
        } catch {
            print("Could not retrieve home characters from service with error: \(error.localizedDescription)")
            self.uiState = .error
        }
    }
}
