//
//  HttpCharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct HttpCharactersApi: CharactersApi {

    public init() { }

    public func getCharacters(upTo limit: Int) async throws -> CharacterResponse {
        return try await decode(url: generateUrl(limit: limit) )
    }

    public func getCharacter(by id: Int) async throws -> CharacterResponse {
        return try await decode(url: generateUrl(route: "/\(id)", limit: 1) )
    }

    public func getComics(upTo limit: Int, by characterId: Int) async throws -> ComicsResponse {
        return try await decode(url: generateUrl(route: "/\(characterId)/comics", limit: limit))
    }

    private func decode<T: Decodable>(url: URL?) async throws -> T {
        guard let url else { throw ApiError.invalidURL}

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else { throw ApiError.badResponse }
        guard (200...299).contains(response.statusCode) else { throw ApiError.statusCodeNotOk }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
