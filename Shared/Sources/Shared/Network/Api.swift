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

    func generateUrl(route: String, limit: Int) throws -> URL
}

public extension Api {

    private var urlString: String { "https://gateway.marvel.com:443/v1/public/characters" }
    private var privateKey: String { "1d0b2d60eca2b1abf4e3aed7ac632004930251fe" }
    private var publicKey: String { "8d3ab5dd12e27b6b47f2516423be5add" }

    private func MD5Hash(from credentials: String) -> String {
        let hash = Insecure.MD5.hash(data: Data(credentials.utf8))
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

    func generateUrl(route: String = "", limit: Int) throws -> URL {
        let timeStamp = String(Date().timeIntervalSince1970)
        let hash = MD5Hash(from: "\(timeStamp)\(privateKey)\(publicKey)")

        guard let url: URL = .init(string: "\(urlString)\(route)?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)&limit=\(limit)" ) else { throw ApiError.invalidURL }

        return url
    }
}
