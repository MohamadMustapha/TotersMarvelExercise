//
//  EventModel.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Foundation

public struct EventModel: Identifiable, Codable {

    public let id: Int

    public let title: String
    public let start: Date
    public let end: Date
    public let imageUrl: String
}
