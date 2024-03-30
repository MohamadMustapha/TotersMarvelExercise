//
//  CharacterProfileView.swift
//
//
//  Created by Mohamad Mustapha on 30/03/2024.
//
import Kingfisher
import Shared
import SwiftUI

public struct CharacterProfileView: View {

    public typealias Item = CharacterModel

    private let item: Item

    public init(item: Item) {
        self.item = item
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            imageView
        }
    }

    @ViewBuilder
    private var imageView: some View {
        KFImage(.init(string: item.imageUrl))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFill()
            .frame(height: 350, alignment: .center)
    }
}

#Preview {
    CharacterProfileView(item: .init(id: 1,
                                     name: "Captain America",
                                     description: "Captain America is america's hero",
                                     imageUrl: "https://shorturl.at/txMRS"))
}
