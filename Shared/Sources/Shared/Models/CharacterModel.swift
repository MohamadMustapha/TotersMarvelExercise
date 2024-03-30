//
//  CharacterListCardModel.swift
//  TotersMarvelExercise
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation

public struct CharacterModel: Identifiable {

    public let id: Int
    public let name: String
    public let description: String
    public let imageUrl: String

    public init(id: Int, name: String, description: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
}
