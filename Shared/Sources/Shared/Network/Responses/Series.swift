//
//  Series.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Foundation

public struct SeriesResponse: Decodable {

    public let data: SeriesDataContainer
}

public struct SeriesDataContainer: Decodable {

    public let results: [Series]
}

public struct Series: Decodable, Identifiable {

    public let id: Int

    public let title: String
    public let thumbnail: Thumbnail
}
