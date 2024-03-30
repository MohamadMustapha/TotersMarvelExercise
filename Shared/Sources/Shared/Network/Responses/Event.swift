//
//  Event.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Foundation

public struct EventsResponse: Decodable {

    public let data: EventsDataContainer
}

public struct EventsDataContainer: Decodable {

    public let results: [Event]
}

public struct Event: Decodable, Identifiable {

    public let id: Int

    public let title: String
    public let start: Date
    public let end: Date
    public let thumbnail: Thumbnail
}
