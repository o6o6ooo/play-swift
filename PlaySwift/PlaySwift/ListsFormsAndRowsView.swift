import SwiftUI

struct ListsFormsAndRowsView: View {
    static let metadata = CataloguePage(
        id: "lists-forms-and-rows",
        title: "Lists, forms, and rows",
        tags: ["Lists", "Layout", "Form"],
        summary: "Study grouped lists, form sections, swipe actions, and disclosure patterns.",
        symbol: "list.bullet.rectangle.fill",
        colour: Color(hex: 0x5856D6),
        destination: .listsFormsAndRows
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
