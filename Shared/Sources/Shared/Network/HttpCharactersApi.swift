//
//  HttpCharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct HttpCharactersApi: CharactersApi {

    public init() { }

    public func getCharacters() async throws -> MarvelCharacterResponse {
        // TODO: refactor the route
        if let url: URL = .init(string: getUrlString(limit: 100)) {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try handleResponse(data: data, response: response)
        }
        throw ApiError.invalidURL
    }

    public func getCharacter(by id: Int) async throws -> MarvelCharacterResponse {
        if let url: URL = .init(string: getUrlString(route: "/\(id)", limit: 3)) {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try handleResponse(data: data, response: response)
        }
        throw ApiError.invalidURL
    }

    private func handleResponse(data: Data, response: URLResponse) throws -> MarvelCharacterResponse {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw ApiError.statusCodeNotOk
        }

        let result = try JSONDecoder().decode(MarvelCharacterResponse.self, from: data)
        return result
    }
}
