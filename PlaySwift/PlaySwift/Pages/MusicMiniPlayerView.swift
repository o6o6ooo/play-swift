import SwiftUI

struct MusicMiniPlayerView: View {
    static let metadata = CataloguePage(
        id: "music-mini-player",
        title: "Music mini player",
        tags: ["Apple Inspired", "Music"],
        summary: "Recreate the compact player, queue entry point, and expansion transition.",
        symbol: "music.note.list",
        colour: .red,
        destination: .musicMiniPlayer
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
