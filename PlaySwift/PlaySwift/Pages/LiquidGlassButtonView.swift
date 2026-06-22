import SwiftUI

struct LiquidGlassButtonView: View {
    static let metadata = CataloguePage(
        id: "liquid-glass-buttons",
        title: "Liquid Glass Buttons",
        tags: ["Liquid Glass", "Buttons", "iOS 26"],
        summary: "Compare iOS 26 Liquid Glass button decoration styles and copy the matching SwiftUI code.",
        symbol: "sparkles",
        colour: Color(hex: 0x007AFF),
        destination: .liquidGlassButtons
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    private let examples = GlassButtonExample.examples

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            ForEach(examples) { example in
                GlassButtonExampleView(example: example)
            }
        }
    }
}

private struct GlassButtonExampleView: View {
    let example: GlassButtonExample

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

private struct GlassButtonExample: Identifiable {
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

private extension GlassButtonExample {
    static let examples: [GlassButtonExample] = [
        GlassButtonExample(
            title: "Glass",
            summary: "The default glass button style for standard actions.",
            code: """
            Button("Continue") {
                // Perform the primary action.
            }
            .buttonStyle(.glass)
            """
        ) {
            Button("Continue") {
            }
            .buttonStyle(.glass)
        },
        GlassButtonExample(
            title: "Prominent Glass",
            summary: "A stronger glass treatment for the most important action in a group. Its colour follows the app accent colour or the nearest tint.",
            code: """
            Button("Start Lesson") {
                // Start the selected lesson.
            }
            .buttonStyle(.glassProminent)
            """
        ) {
            Button("Start Lesson") {
            }
            .buttonStyle(.glassProminent)
        },
        GlassButtonExample(
            title: "Tinted Glass",
            summary: "A glass button tinted with a semantic colour.",
            code: """
            Button("Save Example") {
                // Save this example.
            }
            .buttonStyle(.glass(.regular.tint(.blue)))
            """
        ) {
            Button("Save Example") {
            }
            .buttonStyle(.glass(.regular.tint(.blue)))
        },
        GlassButtonExample(
            title: "Clear Glass",
            summary: "A lighter glass style for compact controls and secondary actions.",
            code: """
            Button {
                // Open more actions.
            } label: {
                Label("More", systemImage: "ellipsis")
            }
            .buttonStyle(.glass(.clear))
            """
        ) {
            Button {
            } label: {
                Label("More", systemImage: "ellipsis")
            }
            .buttonStyle(.glass(.clear))
        },
        GlassButtonExample(
            title: "Icon Glass",
            summary: "A compact icon-only button using the same system glass style.",
            code: """
            Button {
                // Mark as favourite.
            } label: {
                Image(systemName: "heart.fill")
            }
            .buttonStyle(.glass)
            """
        ) {
            Button {
            } label: {
                Image(systemName: "heart.fill")
            }
            .buttonStyle(.glass)
        },
        GlassButtonExample(
            title: "Disabled Glass",
            summary: "The standard disabled state for a glass button.",
            code: """
            Button("Unavailable") {
                // This action is currently unavailable.
            }
            .buttonStyle(.glass)
            .disabled(true)
            """
        ) {
            Button("Unavailable") {
            }
            .buttonStyle(.glass)
            .disabled(true)
        }
    ]

}
