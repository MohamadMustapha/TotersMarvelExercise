//
//  MarvelCharacterService.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation
import Shared

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

    func getComics(by characterId: Int) async throws -> Result<[MarvelComicModel], Error> {
        do {
            let response: ComicsResponse = try await charactersApi.getComics(by: characterId)
            return .success(try await parseMarvelComic(response: response))
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

    private func parseMarvelComic(response: ComicsResponse) async throws -> [MarvelComicModel] {
        return response.data.results.map { .init(id: $0.id,
                                                 title: $0.title,
                                                 imageUrl: "\($0.thumbnail.path).\($0.thumbnail.extension)")
        }
    }
}

