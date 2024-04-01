//
//  ComicCardView.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Kingfisher
import Shared
import SwiftUI

struct DetailsCardView: View {

    struct EventDate {
        let start: String
        let end: String

        init(start: Date, end: Date) {
            let dateFormatter: DateFormatter = .init()
            dateFormatter.dateFormat = "YYYY"
            self.start = dateFormatter.string(from: start)
            self.end = dateFormatter.string(from: end)
        }
    }

    private let eventDate: EventDate?
    private let title: String
    private let imageUrl: String

    public init(eventDate: EventDate? = nil, title: String, imageUrl: String) {
        self.eventDate = eventDate
        self.title = title
        self.imageUrl = imageUrl
    }

    var body: some View {
        VStack(alignment: eventDate == nil ? .center : .leading, spacing: 10) {

            if !imageUrl.isEmpty {
                KFImage(.init(string: imageUrl))
                    .fade(duration: 0.5)
                    .forceTransition(true)
                    .placeholder {
                        ProgressView()
                            .controlSize(.large)
                    }
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            } else {
                VStack(spacing: 10) {
                    Image(systemName: "multiply")
                        .foregroundStyle(.red)
                        .aspectRatio(3/4, contentMode: .fit)
                        .imageScale(.large)

                    Text("unavailable")
                        .font(.callout)
                        .foregroundStyle(.red)
                }
                .frame(width: 150, height: 200)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: eventDate == nil ? .center : .leading) {
                Text(title)
                    .tracking(0.2)
                    .font(.callout)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.center)

                if let eventDate {
                    HStack {
                        Text("\(eventDate.start) - \(eventDate.end)")
                            .tracking(0.2)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

#Preview {

    DetailsCardView(eventDate: .init(start: .now,
                                     end: .distantFuture),
                    title: "Captain America",
                    imageUrl: "https://shorturl.at/vxKO0")
}
