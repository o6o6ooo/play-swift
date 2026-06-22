import SwiftUI

struct MatchedGeometryCardsView: View {
    static let metadata = CataloguePage(
        id: "matched-geometry-cards",
        title: "Matched geometry cards",
        tags: ["Animations", "Matched Geometry"],
        summary: "Open compact cards into detail screens with a smooth shared-element transition.",
        symbol: "rectangle.stack.fill",
        colour: Color(hex: 0xFF2D55),
        destination: .matchedGeometryCards
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePlaceholderView(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        )
    }
}
