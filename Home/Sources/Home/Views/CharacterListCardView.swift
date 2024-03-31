//
//  CharacterListCardView.swift
//  TotersMarvelExercise
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Kingfisher
import Shared
import SwiftUI

public struct CharacterListCardView: View {

    public typealias Item = CharacterModel

    private static let imageSize: CGFloat = 100

    private let item: Item

    public init(item: Item) {
        self.item = item
    }

    public var body: some View {
        VStack(alignment: .leading) {
            KFImage(.init(string: item.imageUrl))
                .placeholder {
                    ProgressView()
                        .controlSize(.large)
                }
                .fade(duration: 0.5)
                .forceTransition(true)
                .resizable()
                .aspectRatio(27/40, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(item.name)
                .tracking(0.2)
                .font(.title2)
                .bold()
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text(item.description)
                .tracking(0.2)
                .font(.caption)
                .foregroundStyle(.gray)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {

    CharacterListCardView(item: .init(id: 1,
                                      name: "Captain America",
                                      description: "Captain America is america's hero",
                                      imageUrl: "https://shorturl.at/txMRS") )
}
