//
//  CharacterListCardView.swift
//  TotersMarvelExercise
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Kingfisher
import SwiftUI

public struct CharacterListCardView: View {

    public typealias Item = CharacterListCardModel

    private static let imageSize: CGFloat = 130

    private let item: Item

    public init(item: CharacterListCardModel) {
        self.item = item
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 10) {
            KFImage(.init(string: item.imageUrl))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(width: Self.imageSize, height: Self.imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 24))

            VStack(alignment: .leading) {
                Text(item.name)
                    .tracking(0.2)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(2)

                Text(item.description)
                    .tracking(0.2)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 10)

            Spacer()
        }
    }
}

#Preview {

    CharacterListCardView(item: .init(id: 1,
                                           name: "Captain America",
                                           description: "Captain America is america's hero",
                                           imageUrl: "https://shorturl.at/txMRS") )
    .padding()
}
