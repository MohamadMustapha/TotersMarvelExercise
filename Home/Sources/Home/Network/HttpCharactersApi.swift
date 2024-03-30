//
//  HttpCharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

struct HttpCharactersApi: CharactersApi {

    func getCharacters() async throws -> [MarvelCharacter] {
        if let url: URL = .init(string: getUrlString(route: "characters")) {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try handleResponse(data: data, response: response)
        }
        throw ApiError.invalidURL
    }

    private func handleResponse(data: Data, response: URLResponse) throws -> [MarvelCharacter] {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw ApiError.statusCodeNotOk
        }

        let result = try JSONDecoder().decode(MarvelCharacterDataWrapper.self, from: data)
        return result.data.results
    }
}
