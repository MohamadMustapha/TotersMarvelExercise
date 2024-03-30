//
//  DetailsServiceImpl.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation
import Shared

protocol DetailsService {

    func getCharacter(by characterId: Int) async throws -> Result<CharacterModel, Error>
    func getComics(upTo limit: Int, by characterId: Int) async throws -> Result<[ComicModel], Error>
    func getEvents(upTo limit: Int, by characterId: Int) async throws -> Result<[EventModel], Error>
}

enum DetailsServiceError: Error {

    case characterNotFound
    case comicNotFound
}
