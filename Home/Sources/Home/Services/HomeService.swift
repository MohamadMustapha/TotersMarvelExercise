//
//  HomeService.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation
import Shared

protocol HomeService {

    func getCharacters() async -> Result<[CharacterModel], Error>
}

struct HomeServiceImpl: HomeService {

    let charactersApi: CharactersApi

    func getCharacters() async -> Result<[CharacterModel], Error> {
        do {
            let response: CharacterResponse = try await charactersApi.getCharacters()
            return .success(await parseMarvelCharacters(response: response))
        } catch {
            return .failure(error)
        }
    }

    private func parseMarvelCharacters(response: CharacterResponse) async -> [CharacterModel] {
        return response.data.results.map { .init(id: $0.id,
                                                 name: $0.name,
                                                 description: $0.description,
                                                 imageUrl: "\($0.thumbnail.path).\($0.thumbnail.extension)") }
    }
}
