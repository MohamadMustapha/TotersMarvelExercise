//
//  HttpCharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct HttpCharactersApi: CharactersApi {

    public init() { }

    public func getCharacters() async throws -> CharacterResponse {
        // TODO: refactor the route
        if let url: URL = .init(string: getUrlString(limit: 100)) {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try handleResponse(data: data, response: response)
        }
        throw ApiError.invalidURL
    }

    public func getCharacter(by id: Int) async throws -> CharacterResponse {
        if let url: URL = .init(string: getUrlString(route: "/\(id)", limit: 1)) {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try handleResponse(data: data, response: response)
        }
        throw ApiError.invalidURL
    }

    public func getComics(by characterId: Int) async throws -> ComicsResponse {
        if let url: URL = .init(string: getUrlString(route: "/\(characterId)/comics", limit: 3)) {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try handleResponse(data: data, response: response)
        }
        throw ApiError.invalidURL

    }

    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw ApiError.statusCodeNotOk
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
