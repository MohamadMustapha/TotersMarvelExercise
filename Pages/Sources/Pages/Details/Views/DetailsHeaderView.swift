//
//  CharacterProfileView.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Kingfisher
import Shared
import SwiftUI

struct DetailsHeaderView: View {

    private let item: CharacterModel

    public init(item: CharacterModel) {
        self.item = item
    }

    var body: some View {
        VStack(spacing: 10) {
            KFImage(.init(string: item.imageUrl))
                .placeholder {
                    ProgressView()
                        .controlSize(.large)
                }
                .fade(duration: 0.5)
                .forceTransition(true)
                .resizable()
                .aspectRatio(27/30, contentMode: .fill)

            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(String(item.id))
                        .tracking(0.2)
                        .italic()
                        .foregroundStyle(.gray)
                        .font(.footnote)
                        .lineLimit(1)
                }

                Text(item.name)
                    .tracking(0.2)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(item.description)
                    .tracking(0.2)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {

    DetailsHeaderView(item: .init(id: 1434534,
                                     name: "Captain America",
                                     description: "Captain america is america's hero",
                                     imageUrl: "https://shorturl.at/txMRS"))
}
