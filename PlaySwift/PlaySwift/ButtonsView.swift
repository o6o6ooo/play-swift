import SwiftUI

struct ButtonsView: View {
    static let metadata = CataloguePage(
        id: "buttons",
        title: "Buttons that feel native",
        tags: ["Components", "Buttons"],
        summary: "Compare prominent, bordered, destructive, menu-backed, and animated button styles.",
        symbol: "button.programmable",
        colour: Color(hex: 0x007AFF),
        destination: .buttons
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
