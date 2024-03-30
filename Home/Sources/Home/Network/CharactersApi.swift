//
//  CharactersApi.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

protocol CharactersApi: Api {

    func getCharacters() async throws -> MarvelCharacterResponse
}
