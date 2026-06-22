import SwiftUI

struct MapsBottomSheetView: View {
    static let metadata = CataloguePage(
        id: "maps-bottom-sheet",
        title: "Maps-style bottom sheet",
        tags: ["Apple Inspired", "Maps"],
        summary: "Explore detents, grabbers, search panels, and floating controls in a Maps-inspired layout.",
        symbol: "map.fill",
        colour: Color(hex: 0x34C759),
        destination: .mapsBottomSheet
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
