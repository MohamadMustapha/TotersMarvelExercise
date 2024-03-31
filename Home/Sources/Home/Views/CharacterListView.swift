//
//  CharacterListView.swift
//  TotersMarvelExercise
//
//  Created by Mohamad Mustapha on 29/03/2024.
//

import Shared
import SwiftUI

public struct CharacterListView: View {

    public typealias Item = CharacterModel

    private let items: [Item]

    private let columns: [GridItem] = [.init(.flexible(), spacing: 20, alignment: .top),
                                       .init(.flexible(), spacing: 20, alignment: .top)]

    public init(items: [Item]) {
        self.items = items
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items, id: \.id) { item in
                    CharacterListCardView(item: item)
                }
            }
        }
        .scrollIfNeeded(axes: .vertical)
        .padding(.horizontal)
    }
}

#Preview {

    CharacterListView(items: [.init(id: 1,
                                    name: "Captain America",
                                    description: "Captain America is jy's hero",
                                    imageUrl: "https://shorturl.at/txMRS"),
                              .init(id: 2,
                                    name: "Captain America",
                                    description: "Captain America is america's hero",
                                    imageUrl: "https://shorturl.at/txMRS"),
                              .init(id: 3,
                                    name: "Captain America",
                                    description: "Captain America is america's hero",
                                    imageUrl: "https://shorturl.at/txMRS"),
                              .init(id: 4,
                                    name: "Captain America",
                                    description: "Captain America is america's hero",
                                    imageUrl: "https://shorturl.at/txMRS")])
    .padding()
}
