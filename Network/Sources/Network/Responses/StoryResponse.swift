//
//   StoriesResponse.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Foundation

public struct StoriesResponse: Decodable {

    public let data: StoriesDataContainer?
}

public struct StoriesDataContainer: Decodable {

    public let results: [Story]?
}

public struct Story: Decodable, Identifiable {

    public let id: Int?

    public let title: String?
    public let thumbnail: Thumbnail?
}
