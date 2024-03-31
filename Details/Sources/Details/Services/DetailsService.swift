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
    func getSeries(upTo limit: Int, by characterId: Int) async throws -> Result<[SeriesModel], Error>
    func getStories(upTo limit: Int, by characterId: Int) async throws -> Result<[StoriesModel], Error>
}

enum DetailsServiceError: Error {

    case characterNotFound
}
