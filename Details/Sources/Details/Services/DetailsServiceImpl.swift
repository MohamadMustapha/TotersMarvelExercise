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

    func getCharacter(by characterId: Int) async throws -> Result<CharacterModel, Error> {
        do {
            let response: CharacterResponse = try await charactersApi.getCharacter(by: characterId)
            return .success(try await parseMarvelCharacter(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getComics(upTo limit: Int, by characterId: Int) async throws -> Result<[ComicModel], Error> {
        do {
            let response: ComicsResponse = try await charactersApi.getComics(upTo: limit, by: characterId)
            return .success(try await parseMarvelComics(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getEvents(upTo limit: Int, by characterId: Int) async throws -> Result<[EventModel], Error> {
        do {
            let response: EventsResponse = try await charactersApi.getEvents(upTo: limit, by: characterId)
            return .success(try await parseMarvelEvents(response: response))
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

    private func parseMarvelComics(response: ComicsResponse) async throws -> [ComicModel] {
        return response.data.results.map { .init(id: $0.id,
                                                 title: $0.title,
                                                 imageUrl: "\($0.thumbnail.path).\($0.thumbnail.extension)")
        }
    }

    private func parseMarvelEvents(response: EventsResponse) async throws -> [EventModel] {
        return response.data.results.map { .init(id: $0.id,
                                                 title: $0.title,
                                                 start: $0.start,
                                                 end: $0.end,
                                                 imageUrl: "\($0.thumbnail.path).\($0.thumbnail.extension)")}
    }
}
