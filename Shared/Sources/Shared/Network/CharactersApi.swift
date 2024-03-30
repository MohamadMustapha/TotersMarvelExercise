//
//  CharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public protocol CharactersApi: Api {

    func getCharacters(upTo limit: Int) async throws -> CharacterResponse
    func getCharacter(by id: Int) async throws -> CharacterResponse
    func getComics(upTo limit: Int, by characterId: Int) async throws -> ComicsResponse
}
