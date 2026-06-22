import SwiftUI

struct PhotosZoomGridView: View {
    static let metadata = CataloguePage(
        id: "photos-zoom-grid",
        title: "Photos zoom grid",
        tags: ["Apple Inspired", "Photos"],
        summary: "Build a photo grid that zooms into a detail view with gesture-driven dismissal.",
        symbol: "photo.on.rectangle.angled",
        colour: Color(hex: 0x5AC8FA),
        destination: .photosZoomGrid
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
