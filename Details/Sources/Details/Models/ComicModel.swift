//
//  ComicModel.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation

public struct ComicModel: Identifiable {

    public let id: Int

    public let title: String
    public let imageUrl: String

    public init(id: Int, title: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
    }
}
