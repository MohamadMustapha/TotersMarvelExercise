//
//  MarvelComics.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation

public struct ComicsResponse: Decodable {

    public let data: ComicsDataContainer
}

public struct ComicsDataContainer: Decodable {

    public let results: [Comic]
}

public struct Comic: Decodable, Identifiable {

    public let id: Int

    public let title: String
    public let thumbnail: Thumbnail
}
