//
//  CharacterItemCarouselView.swift
//
//
//  Created by Mohamad Mustapha on 31/03/2024.
//

import Shared
import SwiftUI

struct DetailsCarouselView: View {

    enum CarouselType {

        case comics([ComicModel])
        case events([EventModel])
        case series([SeriesModel])
        case stories([StoriesModel])

        var title: String {
            switch self {
            case .comics: return "Comics"
            case .events: return "Events"
            case .series: return "Series"
            case .stories: return "Stories"
            }
        }
    }

    let carouselType: CarouselType
    let screenWidth: CGFloat

    private static let numberOfItems: CGFloat = 2.3
    private static let spacing: CGFloat = 20

    private static func calculate(width: CGFloat) -> CGFloat {
        return width / numberOfItems - spacing
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(carouselType.title)
                .tracking(0.2)
                .font(.title)
                .lineLimit(1)
                .padding(.horizontal, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    switch carouselType {
                    case .comics(let comics):
                        ForEach(comics) { comic in
                            DetailsCardView(title: comic.title, imageUrl: comic.imageUrl)
                                .frame(width: Self.calculate(width: screenWidth))
                        }
                    case .events(let events):
                        ForEach(events) { event in
                            DetailsCardView(eventDate: .init(start: event.start,
                                                             end: event.end),
                                            title: event.title,
                                            imageUrl: event.imageUrl)
                                .frame(width: Self.calculate(width: screenWidth))
                        }
                    case .series(let series):
                        ForEach(series) { series in
                            DetailsCardView(title: series.title, imageUrl: series.imageUrl)
                                .frame(width: Self.calculate(width: screenWidth))
                        }
                    case .stories(let stories):
                        ForEach(stories) { story in
                            DetailsCardView(title: story.title, imageUrl: story.imageUrl)
                                .frame(width: Self.calculate(width: screenWidth))
                            Text(story.imageUrl)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .scrollIfNeeded(axes: .horizontal)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        ScrollView(showsIndicators: false) {
            DetailsCarouselView(carouselType: .comics([.init(id: 1,
                                                                   title: "Spider-mancvbdbdfbd",
                                                                   imageUrl: "https://shorturl.at/vxKO0"),
                                                             .init(id: 2,
                                                                   title: "Captain America",
                                                                   imageUrl: "https://shorturl.at/vxKO0"),
                                                             .init(id: 3,
                                                                   title: "Hulk",
                                                                   imageUrl: "https://shorturl.at/vxKO0")]),
                                      screenWidth: proxy.size.width)
        }
    }
}
