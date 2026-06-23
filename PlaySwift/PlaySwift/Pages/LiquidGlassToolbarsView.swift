import SwiftUI

struct LiquidGlassToolbarsView: View {
    static let metadata = CataloguePage(
        id: "liquid-glass-toolbars",
        title: "Liquid Glass Toolbars",
        tags: ["Liquid Glass", "Toolbars", "iOS 26"],
        summary: "Apply Liquid Glass button decoration to standard SwiftUI toolbar actions.",
        symbol: "wrench.and.screwdriver.fill",
        colour: Color(hex: 0x5856D6),
        destination: .liquidGlassToolbars
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    private let examples = LiquidGlassToolbarExample.examples

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            ForEach(examples) { example in
                LiquidGlassToolbarExampleView(example: example)
            }
        }
    }
}

private struct LiquidGlassToolbarExampleView: View {
    let example: LiquidGlassToolbarExample

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(example.title)
                    .font(.title2.weight(.bold))

                Text(example.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            example.preview
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            DisclosureGroup {
                SampleCodeBlock(code: example.code)
                    .padding(.top, 8)
            } label: {
                Label("Sample code", systemImage: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline.weight(.semibold))
            }

            Divider()
        }
    }
}

private struct LiquidGlassToolbarExample: Identifiable {
    let id = UUID()
    let title: String
    let summary: String
    let code: String
    let preview: AnyView

    init<Preview: View>(
        title: String,
        summary: String,
        code: String,
        @ViewBuilder preview: () -> Preview
    ) {
        self.title = title
        self.summary = summary
        self.code = code
        self.preview = AnyView(preview())
    }
}

private extension LiquidGlassToolbarExample {
    static let examples: [LiquidGlassToolbarExample] = [
        LiquidGlassToolbarExample(
            title: "Mail-style bottom actions",
            summary: "Group related bottom actions on the left and keep the primary compose action separate on the right.",
            code: """
            NavigationStack {
                MailboxView()
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button {
                                // Reply.
                            } label: {
                                Image(systemName: "arrowshape.turn.up.left")
                            }
                            .buttonStyle(.glass(.clear))

                            Button {
                                // Move to folder.
                            } label: {
                                Image(systemName: "folder")
                            }
                            .buttonStyle(.glass(.clear))

                            Button(role: .destructive) {
                                // Delete.
                            } label: {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(.glass(.clear))

                            Spacer()

                            Button {
                                // Compose.
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            .buttonStyle(.glass(.clear))
                        }
                    }
            }
            """
        ) {
            SplitToolbarPreview(
                leading: [
                    "arrowshape.turn.up.left",
                    "folder",
                    "trash"
                ],
                trailing: [
                    "square.and.pencil"
                ]
            )
        },
        LiquidGlassToolbarExample(
            title: "Photos-style actions",
            summary: "Use separate glass groups for single actions and a centred cluster of related controls.",
            code: """
            NavigationStack {
                PhotoView()
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button {
                                // Share.
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                            .buttonStyle(.glass(.clear))

                            Spacer()

                            Button {
                                // Favourite.
                            } label: {
                                Image(systemName: "heart")
                            }
                            .buttonStyle(.glass(.clear))

                            Button {
                                // Show info.
                            } label: {
                                Image(systemName: "info.circle")
                            }
                            .buttonStyle(.glass(.clear))

                            Button {
                                // Adjust.
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                            }
                            .buttonStyle(.glass(.clear))

                            Spacer()

                            Button(role: .destructive) {
                                // Delete.
                            } label: {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(.glass(.clear))
                        }
                    }
            }
            """
        ) {
            SplitToolbarPreview(
                leading: [
                    "square.and.arrow.up"
                ],
                centre: [
                    "heart",
                    "info.circle",
                    "slider.horizontal.3"
                ],
                trailing: [
                    "trash"
                ]
            )
        },
        LiquidGlassToolbarExample(
            title: "Search toolbar",
            summary: "Combine standalone controls with a glass search field in the bottom toolbar area.",
            code: """
            struct SearchToolbarView: View {
                @State private var searchText = ""

                var body: some View {
                    NavigationStack {
                        MessageListView()
                            .toolbar {
                                ToolbarItemGroup(placement: .bottomBar) {
                                    Button {
                                        // Open sidebar.
                                    } label: {
                                        Image(systemName: "line.3.horizontal")
                                    }
                                    .buttonStyle(.glass(.clear))

                                    TextField("Search", text: $searchText)
                                        .textFieldStyle(.plain)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(.regularMaterial, in: Capsule())

                                    Button {
                                        // Compose.
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                    }
                                    .buttonStyle(.glass(.clear))
                                }
                            }
                    }
                }
            }
            """
        ) {
            SearchToolbarPreview()
        },
        LiquidGlassToolbarExample(
            title: "Editing top toolbar",
            summary: "Split top toolbar controls into leading, principal, and trailing placements.",
            code: """
            NavigationStack {
                EditorView()
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Button {
                                // Undo.
                            } label: {
                                Image(systemName: "arrow.uturn.backward")
                            }
                            .buttonStyle(.glass(.clear))

                            Button {
                                // Redo.
                            } label: {
                                Image(systemName: "arrow.uturn.forward")
                            }
                            .buttonStyle(.glass(.clear))
                        }

                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button {
                                // Mark up.
                            } label: {
                                Image(systemName: "pencil.tip")
                            }
                            .buttonStyle(.glass(.clear))

                            Button {
                                // More actions.
                            } label: {
                                Image(systemName: "ellipsis")
                            }
                            .buttonStyle(.glass(.clear))
                        }
                    }
            }
            """
        ) {
            TopEditingToolbarPreview()
        }
    ]
}

private struct SplitToolbarPreview: View {
    let leading: [String]
    let centre: [String]
    let trailing: [String]

    init(leading: [String], centre: [String] = [], trailing: [String]) {
        self.leading = leading
        self.centre = centre
        self.trailing = trailing
    }

    var body: some View {
        HStack {
            ToolbarButtonGroup(symbols: leading)

            Spacer()

            if centre.isEmpty == false {
                ToolbarButtonGroup(symbols: centre)
                Spacer()
            }

            ToolbarButtonGroup(symbols: trailing)
        }
        .padding(16)
    }
}

private struct SearchToolbarPreview: View {
    var body: some View {
        HStack(spacing: 14) {
            ToolbarButtonGroup(symbols: ["line.3.horizontal"])

            Button {
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.body)

                    Text("Search")
                        .font(.body)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Image(systemName: "mic")
                        .font(.body)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
            }
            .buttonStyle(.glass(.clear))
            .buttonBorderShape(.capsule)

            ToolbarButtonGroup(symbols: ["square.and.pencil"])
        }
        .padding(16)
    }
}

private struct TopEditingToolbarPreview: View {
    var body: some View {
        HStack {
            ToolbarButtonGroup(symbols: [
                "arrow.uturn.backward",
                "arrow.uturn.forward"
            ])

            Spacer()

            ToolbarButtonGroup(symbols: [
                "pencil.tip",
                "ellipsis"
            ])
        }
        .padding(16)
    }
}

private struct ToolbarButtonGroup: View {
    let symbols: [String]

    var body: some View {
        if symbols.count == 1, let symbol = symbols.first {
            Button {
            } label: {
                Image(systemName: symbol)
								.font(.body)
                    .frame(width: 32, height: 32)
            }
            .buttonStyle(.glass(.clear))
            .buttonBorderShape(.circle)
        } else {
            Button {
            } label: {
                HStack(spacing: 12) {
                    ForEach(symbols, id: \.self) { symbol in
                        Image(systemName: symbol)
                            .frame(width: 28, height: 28)
														.font(.body)
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
            }
            .buttonStyle(.glass(.clear))
            .buttonBorderShape(.capsule)
        }
    }
}
