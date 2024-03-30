//
//  EventModel.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Foundation

public struct EventModel: Identifiable {

    public let id: Int

    public let title: String
    public let start: Date
    public let end: Date
    public let imageUrl: String

    init(id: Int, title: String, start: Date, end: Date, imageUrl: String) {
        self.id = id
        self.title = title
        self.start = start
        self.end = end
        self.imageUrl = imageUrl
    }
}
