//
//  DetailsViewModel.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Network
import Nuke
import Shared
import SwiftUI

@MainActor
class DetailsViewModel: ObservableObject {

    enum UIState {

        struct ViewData: Codable {

            let character: CharacterModel
            let comics: [ComicModel]
            let series: [SeriesModel]
            let events: [EventModel]
            let stories: [StoriesModel]
        }
        case loading, loaded(data: ViewData), error
    }

    #warning("Add environment variable")
    private static func characterCacheKey(id: Int) -> String {
        return "character-\(id)"
    }

    @Published private(set) var state: UIState = .loading

    private let detailsService: DetailsService = DetailsServiceImpl(charactersApi: HttpCharactersApi())

    public init() { }

    func onAppear(characterId: Int, dataCache: DataCache?) async {
        do {
            let viewData: UIState.ViewData
            if dataCache?.containsData(for: Self.characterCacheKey(id: characterId)) == true,
               let data: Data = dataCache?.cachedData(for: Self.characterCacheKey(id: characterId)) {
                viewData = try JSONDecoder().decode(UIState.ViewData.self, from: data)
            } else {
                async let character: CharacterModel = detailsService.getCharacter(of: characterId).get()
                async let comics: [ComicModel] = detailsService.getComics(upTo: 6, of: characterId).get()
                async let events: [EventModel] = detailsService.getEvents(upTo: 6, of: characterId).get()
                async let series: [SeriesModel] = detailsService.getSeries(upTo: 6, of: characterId).get()
                async let stories: [StoriesModel] = detailsService.getStories(upTo: 6, of: characterId).get()

                viewData = try await .init(character: character,
                                           comics: comics,
                                           series: series,
                                           events: events,
                                           stories: stories)
                let data: Data = try JSONEncoder().encode(viewData)
                dataCache?.storeData(data, for: Self.characterCacheKey(id: characterId))
            }

            withAnimation {
                state = .loaded(data: viewData)
            }
        } catch {
            print("Could not retrieve view data from service with error: \(error)")
            state = .error
        }
    }
}
