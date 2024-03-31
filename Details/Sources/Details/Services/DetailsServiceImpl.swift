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

    func getCharacter(of characterId: Int) async throws -> Result<CharacterModel, Error> {
        do {
            let response: CharacterResponse = try await charactersApi.getCharacter(by: characterId)
            return .success(try parseMarvelCharacter(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getComics(upTo limit: Int, of characterId: Int) async throws -> Result<[ComicModel], Error> {
        do {
            let response: ComicsResponse = try await charactersApi.getComics(upTo: limit, by: characterId)
            return .success(try parseMarvelComics(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getEvents(upTo limit: Int, of characterId: Int) async throws -> Result<[EventModel], Error> {
        do {
            let response: EventsResponse = try await charactersApi.getEvents(upTo: limit, by: characterId)
            return .success(try parseMarvelEvents(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getSeries(upTo limit: Int, of characterId: Int) async throws -> Result<[SeriesModel], Error> {
        do {
            let response: SeriesResponse = try await charactersApi.getSeries(upTo: limit, by: characterId)
            return .success(try parseMarvelSeries(response: response))
        } catch {
            return .failure(error)
        }
    }

    func getStories(upTo limit: Int, of characterId: Int) async throws -> Result<[StoriesModel], Error> {
        do {
            let response: StoriesResponse = try await charactersApi.getStories(upTo: limit, by: characterId)
            return .success(try parseMarvelStories(response: response))
        } catch {
            return .failure(error)
        }
    }

    private func parseMarvelCharacter(response: CharacterResponse) throws -> CharacterModel {
        guard let marvelCharacter: Character =  response.data?.results?.first else {
            throw DetailsServiceError.objectNotFound
        }
        guard let id: Int = marvelCharacter.id else { throw DetailsServiceError.invalidCharacter}

        return .init(id: id,
                     name: marvelCharacter.name ?? "",
                     description: marvelCharacter.description ?? "" ,
                     imageUrl: parseThumbnail(thumbnail: marvelCharacter.thumbnail))

    }

    private func parseMarvelComics(response: ComicsResponse) throws -> [ComicModel] {
        guard let results: [Comic] = response.data?.results else { throw DetailsServiceError.objectNotFound }

        return results.compactMap {
            guard let id: Int = $0.id else { return nil }

            return .init(id: id,
                         title: $0.title ?? "",
                         imageUrl: parseThumbnail(thumbnail: $0.thumbnail))
        }
    }

    private func parseMarvelEvents(response: EventsResponse) throws -> [EventModel] {
        guard let results: [Event] = response.data?.results else { throw DetailsServiceError.objectNotFound }

        return results.compactMap {
            guard let id: Int = $0.id,
                  let start: Date = $0.start,
                  let end: Date = $0.end else { return nil }

            return .init(id: id,
                         title: $0.title ?? "",
                         start: start,
                         end: end,
                         imageUrl: parseThumbnail(thumbnail: $0.thumbnail))
        }
    }

    private func parseMarvelSeries(response: SeriesResponse) throws -> [SeriesModel] {
        guard let results: [Series] = response.data?.results else { throw DetailsServiceError.objectNotFound }

        return results.compactMap {
            guard let id: Int = $0.id else { return nil }

            return .init(id: id,
                         title: $0.title ?? "",
                         imageUrl: parseThumbnail(thumbnail: $0.thumbnail))
        }
    }

    private func parseMarvelStories(response: StoriesResponse) throws -> [StoriesModel] {
        guard let results: [Story] = response.data?.results else { throw DetailsServiceError.objectNotFound }

        return results.compactMap {
            guard let id: Int = $0.id else { return nil }

            return .init(id: id,
                         title: $0.title ?? "",
                         imageUrl: parseThumbnail(thumbnail: $0.thumbnail))
        }
    }

    private func parseThumbnail(thumbnail: Thumbnail?) -> String {
        guard let thumbnail,
              let path: String = thumbnail.path,
              let `extension`: String = thumbnail.extension else { return "" }

        return "\(path).\(`extension`)"
    }
}
