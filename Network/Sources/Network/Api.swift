//
//  Api.swift
//
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import CryptoKit
import Foundation

public enum ApiError: Error {

    case badResponse
    case invalidURL
    case statusCodeNotOk
}

public protocol Api {

    func generateUrl(route: String, limit: Int, offset: Int) throws -> URL
}

public extension Api {

    private var urlString: String { "https://gateway.marvel.com:443/v1/public/characters" }
//    private var privateKey: String { "1d0b2d60eca2b1abf4e3aed7ac632004930251fe" }
//    private var publicKey: String { "8d3ab5dd12e27b6b47f2516423be5add" }
    private var privateKey: String { "22c1b0ebb9924a1081b060799ebf68083eca9fcc" }
    private var publicKey: String { "4867dbc6605cd4af0b4bdc2165db5eb8" }

    private func MD5Hash(from credentials: String) -> String {
        let hash = Insecure.MD5.hash(data: Data(credentials.utf8))
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

    func generateUrl(route: String = "", limit: Int, offset: Int = 0) throws -> URL {
        let timeStamp = String(Date().timeIntervalSince1970)
        let hash = MD5Hash(from: "\(timeStamp)\(privateKey)\(publicKey)")

        guard let url: URL = .init(string: "\(urlString)\(route)?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)&limit=\(limit)&offset=\(offset)")
        else { throw ApiError.invalidURL }

        return url
    }
}
