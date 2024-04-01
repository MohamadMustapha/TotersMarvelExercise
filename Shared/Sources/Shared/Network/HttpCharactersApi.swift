//
//  HttpCharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct HttpCharactersApi: CharactersApi {

    public init() { }

    public func getCharacters(upTo limit: Int, offset: Int) async throws -> CharacterResponse {
        return try await decode(url: generateUrl(limit: limit, offset: offset) )
    }

    public func getCharacter(by id: Int) async throws -> CharacterResponse {
        return try await decode(url: generateUrl(route: "/\(id)", limit: 1) )
    }

    public func getComics(upTo limit: Int, by characterId: Int) async throws -> ComicsResponse {
        return try await decode(url: generateUrl(route: "/\(characterId)/comics", limit: limit))
    }

    public func getEvents(upTo limit: Int, by characterId: Int) async throws -> EventsResponse {
        return try await decode(url: generateUrl(route: "/\(characterId)/events", limit: limit))
    }

    public func getSeries(upTo limit: Int, by characterId: Int) async throws -> SeriesResponse {
        return try await decode(url: generateUrl(route: "/\(characterId)/series", limit: limit))
    }

    public func getStories(upTo limit: Int, by characterId: Int) async throws -> StoriesResponse {
        return try await decode(url: generateUrl(route: "/\(characterId)/stories", limit: limit))
    }

    private func decode<T: Decodable>(url: URL) async throws -> T {
        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else { throw ApiError.badResponse }
        guard (200...299).contains(response.statusCode) else { throw ApiError.statusCodeNotOk }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
