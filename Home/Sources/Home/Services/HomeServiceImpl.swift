//
//  HomeServiceImpl.swift
//
//
//  Created by Mohamad Mustapha on 01/04/2024.
//

import Foundation
import Shared

struct HomeServiceImpl: HomeService {

    let charactersApi: CharactersApi

    func getCharacters() async -> Result<[CharacterModel], Error> {
        do {
            let response: CharacterResponse = try await charactersApi.getCharacters(upTo: 100)
            return .success(try parseMarvelCharacters(response: response))
        } catch {
            return .failure(error)
        }
    }

    private func parseMarvelCharacters(response: CharacterResponse) throws -> [CharacterModel] {
        guard let results: [Character] = response.data?.results else { throw HomeServiceError.noObjectsFound }

        return results.compactMap {
            guard let id: Int = $0.id else { return nil }

            return .init(id: id,
                         name: $0.name ?? "",
                         description: $0.description ?? "",
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
