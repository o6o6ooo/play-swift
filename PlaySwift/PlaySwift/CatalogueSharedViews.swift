import SwiftUI

struct TagRow: View {
    let tags: [String]
    let colour: Color

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(colour)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(colour.opacity(0.12), in: Capsule())
                }
            }
        }
    }
}

struct FavouriteToolbarButton: ToolbarContent {
    let isFavourite: Bool
    let action: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(action: action) {
                Image(systemName: isFavourite ? "bookmark.fill" : "bookmark")
            }
            .accessibilityLabel(isFavourite ? "Remove from Favourites" : "Add to Favourites")
        }
    }
}
