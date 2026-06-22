import SwiftUI

struct WalletCardStackView: View {
    static let metadata = CataloguePage(
        id: "wallet-card-stack",
        title: "Wallet card stack",
        tags: ["Apple Inspired", "Wallet"],
        summary: "Experiment with stacked cards, depth, scrolling, and tap-to-expand interactions.",
        symbol: "creditcard.fill",
        colour: Color(hex: 0xFFCC00),
        destination: .walletCardStack
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
