//
//  MarvelCharacterService.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation
import Shared

protocol DetailsService {

    func getCharacter(by id: Int) async throws -> Result<MarvelCharacterModel, Error>
}

enum DetailsServiceError: Error {
    case characterNotFound
}

struct DetailsServiceImpl: DetailsService {

    let charactersApi: CharactersApi

    func getCharacter(by id: Int) async throws -> Result<MarvelCharacterModel, Error> {
        do {
            let response: MarvelCharacterResponse = try await charactersApi.getCharacter(by: id)
            return .success(try await parseMarvelCharacter(response: response))
        } catch {
            return .failure(error)
        }
    }

    private func parseMarvelCharacter(response: MarvelCharacterResponse) async throws -> MarvelCharacterModel {
        guard let marvelCharacter: MarvelCharacter =  response.data.results.first else {
            throw DetailsServiceError.characterNotFound
        }
        return .init(id: marvelCharacter.id,
                     name: marvelCharacter.name,
                     description: marvelCharacter.description,
                     imageUrl: "\(marvelCharacter.thumbnail.path).\(marvelCharacter.thumbnail.extension)")

    }
}

