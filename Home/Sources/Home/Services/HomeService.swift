//
//  HomeService.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Foundation
import Shared

protocol HomeService {

    func getCharacters() async -> Result<[CharacterModel], Error>
}

enum HomeServiceError: Error {
    
    case noObjectsFound
}
