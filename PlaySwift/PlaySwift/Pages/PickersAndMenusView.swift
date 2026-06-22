import SwiftUI

struct PickersAndMenusView: View {
    static let metadata = CataloguePage(
        id: "pickers-and-menus",
        title: "Pickers and menus",
        tags: ["Controls", "Picker", "Menu"],
        summary: "Try segmented controls, inline pickers, wheel pickers, menus, and selection states.",
        symbol: "filemenu.and.selection",
        colour: Color(hex: 0xFF9500),
        destination: .pickersAndMenus
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
