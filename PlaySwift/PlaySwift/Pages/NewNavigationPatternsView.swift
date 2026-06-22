import SwiftUI

struct NewNavigationPatternsView: View {
    static let metadata = CataloguePage(
        id: "new-navigation-patterns",
        title: "New navigation patterns",
        tags: ["Navigation", "iOS 26"],
        summary: "Prototype current tab, toolbar, and split-view ideas as the platform evolves.",
        symbol: "sidebar.leading",
        colour: Color(hex: 0x5856D6),
        destination: .newNavigationPatterns
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
