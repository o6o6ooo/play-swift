import SwiftUI

struct CataloguePlaceholderView: View {
    let page: CataloguePage
    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PageIcon(page: page)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 8) {
                    TagRow(tags: page.tags, colour: page.colour)

                    Text(page.title)
                        .font(.largeTitle.weight(.bold))

                    Text(page.summary)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
        }
        .navigationTitle(page.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            FavouriteToolbarButton(isFavourite: isFavourite, action: toggleFavourite)
        }
        .background(.background)
    }
}

private struct PageIcon: View {
    let page: CataloguePage

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            page.colour.opacity(0.92),
                            page.colour.opacity(0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Image(systemName: page.symbol)
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.22), radius: 8, y: 4)
        }
        .frame(width: 132, height: 132)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
