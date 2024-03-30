//
//  DetailsServiceImpl.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation
import Shared

struct DetailsServiceImpl: DetailsService {

    let charactersApi: CharactersApi

    func getCharacter(by id: Int) async throws -> Result<CharacterModel, Error> {
        do {
            let response: CharacterResponse = try await charactersApi.getCharacter(by: id)
            return .success(try await parseMarvelCharacter(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getComics(upTo limit: Int, by characterId: Int) async throws -> Result<[ComicModel], Error> {
        do {
            let response: ComicsResponse = try await charactersApi.getComics(upTo: limit, by: characterId)
            return .success(try await parseMarvelComic(response: response))
        } catch {
            return .failure(error)
        }
    }

    private func parseMarvelCharacter(response: CharacterResponse) async throws -> CharacterModel {
        guard let marvelCharacter: Character =  response.data.results.first else {
            throw DetailsServiceError.characterNotFound
        }
        return .init(id: marvelCharacter.id,
                     name: marvelCharacter.name,
                     description: marvelCharacter.description,
                     imageUrl: "\(marvelCharacter.thumbnail.path).\(marvelCharacter.thumbnail.extension)")

    }

    private func parseMarvelComic(response: ComicsResponse) async throws -> [ComicModel] {
        return response.data.results.map { .init(id: $0.id,
                                                 title: $0.title,
                                                 imageUrl: "\($0.thumbnail.path).\($0.thumbnail.extension)")
        }
    }
}

