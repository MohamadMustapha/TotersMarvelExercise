//
//  MarvelCharacter.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

struct MarvelCharacterResponse: Decodable {

    let data: MarvelCharacterDataContainer
}

struct MarvelCharacterDataContainer: Decodable {

    let results: [MarvelCharacter]
}

struct Thumbnail: Decodable {

    let path: String
    let `extension`: String
}

struct MarvelCharacter: Decodable, Identifiable {

    let id: Int

    let name: String
    let description: String
    let thumbnail: Thumbnail
}
