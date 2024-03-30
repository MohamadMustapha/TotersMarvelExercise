//
//  HomeViewModel.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation
import Shared

class HomeViewModel: ObservableObject {

    private let homeService: HomeService = HomeServiceImpl(charactersApi: HttpCharactersApi())
    @Published private(set) var characters: [CharacterModel] = []

    init() { }

    func onAppear() async {
        do {
            let marvelCharacters = try await homeService.getCharacters().get()
            characters = marvelCharacters.map { .init(id: $0.id,
                                                      name: $0.name,
                                                      description: $0.description,
                                                      imageUrl: "\($0.thumbnail.path).\($0.thumbnail.extension)") }
        } catch {
            print("Could not retrieve characters from service with error: \(error.localizedDescription)")
        }
    }
}
