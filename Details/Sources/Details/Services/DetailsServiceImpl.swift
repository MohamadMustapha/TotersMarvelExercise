//
//  DetailsServiceImpl.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation
import Shared

protocol DetailsService {

    func getCharacter(by id: Int) async throws -> Result<MarvelCharacterModel, Error>

    func getComics(by characterId: Int) async throws -> Result<[MarvelComicModel], Error>
}

enum DetailsServiceError: Error {

    case characterNotFound
    case comicNotFound
}
