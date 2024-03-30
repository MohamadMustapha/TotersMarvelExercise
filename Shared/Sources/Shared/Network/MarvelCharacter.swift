//
//  MarvelCharacter.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct MarvelCharacterResponse: Decodable {

    public let data: MarvelCharacterDataContainer
}

public struct MarvelCharacterDataContainer: Decodable {

    public let results: [MarvelCharacter]
}

public struct Thumbnail: Decodable {

    public let path: String
    public let `extension`: String
}

public struct MarvelCharacter: Decodable, Identifiable {

    public let id: Int

    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
}
