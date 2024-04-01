//
//  EnvironmentValues+CacheData.swift
//
//
//  Created by Mohamad Mustapha on 02/04/2024.
//

import Nuke
import SwiftUI

public extension EnvironmentValues {

    var appDataCache: DataCache? {
        get { self[AppDataCache.self] }
        set { self[AppDataCache.self] = newValue }
    }
}

private struct AppDataCache : EnvironmentKey {

    static let defaultValue: DataCache? = {
        do {
            return try .init(name: "TotersMarvelCache")
        } catch {
            return nil
        }
    }()
}
