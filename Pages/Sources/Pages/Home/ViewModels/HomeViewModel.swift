//
//  HomeViewModel.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Network
import Nuke
import Shared
import SwiftUI

@MainActor
class HomeViewModel : ObservableObject {

    enum UIState {

        case loading, loaded(characters: [CharacterModel]), error
    }

    #warning("Add environment variable")
    private static let charactersCacheKey: String = "characters-cache-key"

    @Published private(set) var uiState: UIState = .loading

    private let homeService: HomeService = HomeServiceImpl(charactersApi: HttpCharactersApi())

    init() { }

    func onAppear(dataCache: DataCache?) async {
        do {
            let characters: [CharacterModel]
            if dataCache?.containsData(for: Self.charactersCacheKey) == true,
               let data: Data = dataCache?.cachedData(for: Self.charactersCacheKey) {
                characters = try JSONDecoder().decode([CharacterModel].self, from: data)
            } else {
                characters = try await homeService.getCharacters().get()
                let data: Data = try JSONEncoder().encode(characters)
                dataCache?.storeData(data, for: Self.charactersCacheKey)
            }

            withAnimation {
                uiState = .loaded(characters: characters)
            }
        } catch {
            print("Could not retrieve characters from service with error: \(error)")
            uiState = .error
        }
    }

    func clearCharactersAndRefetch(dataCache: DataCache?) async {
        withAnimation {
            uiState = .loading
        }
        await onAppear(dataCache: dataCache)
    }
}
