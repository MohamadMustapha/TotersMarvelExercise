//
//  DetailsViewModel.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import SwiftUI
import Shared

class DetailsViewModel: ObservableObject {

    enum UIState {

        struct ViewData {

            let character: CharacterModel
            let comics: [ComicModel]
            let series: [SeriesModel]
            let events: [EventModel]
            let stories: [StoriesModel]
        }
        case loading, loaded(data: ViewData), error
    }

    @Published private(set) var state: UIState = .loading
    
    private let characterID: Int
    private let detailsService: DetailsService = DetailsServiceImpl(charactersApi: HttpCharactersApi())

    public init(characterID: Int) {
        self.characterID = characterID
    }

    func onAppear() async {
        do {
            async let character: CharacterModel = detailsService.getCharacter(by: characterID).get()
            async let comics: [ComicModel] = detailsService.getComics(upTo: 3, by: characterID).get()
            async let events: [EventModel] = detailsService.getEvents(upTo: 3, by: characterID).get()
            async let series: [SeriesModel] = detailsService.getSeries(upTo: 3, by: characterID).get()
            async let stories: [StoriesModel] = detailsService.getStories(upTo: 3, by: characterID).get()

            let data: UIState.ViewData = try await .init(character: character,
                                                         comics: comics,
                                                         series: series,
                                                         events: events,
                                                         stories: stories)
            withAnimation {
                state = .loaded(data: data)
            }

        } catch {
            print("couldn't load details, error \(error.localizedDescription)")
            state = .error
        }
    }
}
