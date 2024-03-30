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

    public init(items: [Item]) {
        self.items = items
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    CharacterListCardView(item: item)
                    Divider()
                        .frame(height: 0.5)
                        .foregroundStyle(.gray)
                        .isHidden(index == items.count - 1, remove: index == items.count - 1)
                }
            }
        }
        .scrollIfNeeded(axes: .vertical)
        .padding()
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {

    CharacterListView(items: [.init(id: 1,
                                    name: "Captain America",
                                    description: "Captain America is america's hero",
                                    imageUrl: "https://shorturl.at/txMRS"),
                              .init(id: 2,
                                    name: "Captain America",
                                    description: "Captain America is america's hero",
                                    imageUrl: "https://shorturl.at/txMRS")])
}
