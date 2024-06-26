//
//  ComicModel.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//

import Foundation

public struct ComicModel: Identifiable, Codable {

    public let id: Int

    public let title: String
    public let imageUrl: String
}
