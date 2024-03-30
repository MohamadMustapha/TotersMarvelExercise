//
//  HomeService.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

enum HomeServiceError: Error {

    case apiFailed
}

protocol HomeService {

    func getCharacters() async -> Result<[MarvelCharacter], HomeServiceError>
}

struct HomeServiceImpl: HomeService {

    let charactersApi: CharactersApi

    func getCharacters() async -> Result<[MarvelCharacter], HomeServiceError> {
        do {
            let result = try await charactersApi.getCharacters()
            return .success(result)
        } catch {
            return .failure(.apiFailed)
        }
    }
}
