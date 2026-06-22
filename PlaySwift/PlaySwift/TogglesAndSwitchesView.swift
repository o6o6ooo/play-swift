import SwiftUI

struct TogglesAndSwitchesView: View {
    static let metadata = CataloguePage(
        id: "toggles-and-switches",
        title: "Toggles and switches",
        tags: ["Controls", "Toggle"],
        summary: "Inspect tinting, labels, disabled states, and settings-style toggle rows.",
        symbol: "switch.2",
        colour: Color(hex: 0x32ADE6),
        destination: .togglesAndSwitches
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
