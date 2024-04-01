//
//  CharacterResponse.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct CharacterResponse: Decodable {

    public let data: CharacterDataContainer?
}

public struct CharacterDataContainer: Decodable {

    public let results: [Character]?
    public let total: Int?
}

public struct Character: Decodable, Identifiable {

    public let id: Int?

    public let name: String?
    public let description: String?
    public let thumbnail: Thumbnail?
}
