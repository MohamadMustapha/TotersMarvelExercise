//
//  HomeServiceImpl.swift
//
//
//  Created by Mohamad Mustapha on 01/04/2024.
//

import Foundation
import Network
import Shared

struct HomeServiceImpl: HomeService {

    let charactersApi: CharactersApi

    private static let limit: Int = 100

    func getCharacters() async -> Result<[CharacterModel], Error> {
        do {
            let response: CharacterResponse = try await charactersApi.getCharacters(upTo: Self.limit, offset: 0)

            guard let total: Int = response.data?.total else { throw HomeServiceError.noTotalFound }

            var characters: [CharacterModel] = []
            // Reserve capacity to avoid multiple reallocations
            characters.reserveCapacity(total)
            // Append characters from the first response
            characters.append(contentsOf: try parseMarvelCharacters(response: response))
            // Create task group to make parallel calls to retrieve all characters past the limit
            characters.append(
                contentsOf: try await withThrowingTaskGroup(
                    of: CharacterResponse.self,
                    returning: [CharacterModel].self
                ) { taskGroup in
                    for offset in stride(from: Self.limit, to: total, by: Self.limit) {
                        // fetch 100 characters starting from the offset
                        taskGroup.addTask { try await charactersApi.getCharacters(upTo: Self.limit, offset: offset) }
                    }

                    var characters: [CharacterModel] = []
                    // Use taskGroup.next() to cancel the task group if any child task throws an error
                    while let response: CharacterResponse = try await taskGroup.next() {
                        characters.append(contentsOf: try parseMarvelCharacters(response: response))
                    }
                    return characters
                }
            )
            return .success(characters)
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
