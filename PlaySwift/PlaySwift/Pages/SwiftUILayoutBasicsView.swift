import SwiftUI

struct SwiftUILayoutBasicsView: View {
    static let metadata = CataloguePage(
        id: "swiftui-layout-basics",
        title: "SwiftUI Layout Basics",
        tags: ["Basic", "Layout", "SwiftUI"],
        summary: "Learn how VStack, HStack, ZStack, Spacer, padding, and frame work together to shape a SwiftUI screen.",
        symbol: "square.stack.3d.up.fill",
        colour: Color(hex: 0x007AFF),
        destination: .swiftUILayoutBasics
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            LayoutBasicsSection(
                title: "VStack",
                summary: "VStack places views from top to bottom.",
                code: """
                VStack(alignment: .leading, spacing: 12) {
                    Text("Title")
                        .padding()
                        .background(.blue, in: RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)

                    Text("Subtitle")
                        .padding()
                        .background(.cyan, in: RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)

                    Button("Continue") {
                        // Continue to the next step.
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
                """,
                preview: {
                    VStack(alignment: .leading, spacing: 10) {
                        LayoutBlock("Title", colour: Color(hex: 0x007AFF))
                        LayoutBlock("Subtitle", colour: Color(hex: 0x5AC8FA))
                        LayoutBlock("Continue", colour: Color(hex: 0x34C759))
                    }
                }
            )

            LayoutBasicsSection(
                title: "HStack",
                summary: "HStack places views from leading to trailing.",
                code: """
                HStack(spacing: 12) {
                    Image(systemName: "star.fill")
                    Text("Favourite")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                """,
                preview: {
                    HStack(spacing: 10) {
                        LayoutIcon("star.fill", colour: Color(hex: 0xFFCC00))
                        LayoutBlock("Favourite", colour: Color(hex: 0xFF9500))
                        Spacer(minLength: 0)
                        LayoutIcon("chevron.right", colour: Color(hex: 0x8E8E93))
                    }
                }
            )

            LayoutBasicsSection(
                title: "ZStack",
                summary: "ZStack layers views front to back. It is useful for badges, overlays, and text on top of backgrounds.",
                code: """
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blue)

                    Text("New")
                        .padding(8)
                        .background(.thinMaterial, in: Capsule())
                }
                """,
                preview: {
                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(hex: 0x5856D6).gradient)
                            .frame(height: 96)

                        Text("New")
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.thinMaterial, in: Capsule())
                            .padding(10)
                    }
                }
            )

            LayoutBasicsSection(
                title: "Spacer, padding, and frame",
                summary: "Spacer creates flexible empty space. Padding adds breathing room. Frame proposes a size or alignment.",
                code: """
                HStack {
                    Text("Leading")
                    Spacer()
                    Text("Trailing")
                }
                .padding()
                .frame(maxWidth: .infinity)
                """,
                preview: {
                    HStack {
                        LayoutBlock("Leading", colour: Color(hex: 0x34C759))
                        Spacer()
                        LayoutBlock("Trailing", colour: Color(hex: 0xFF2D55))
                    }
                    .padding(12)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            )
        }
    }
}

private struct LayoutBasicsSection<Preview: View>: View {
    let title: String
    let summary: String
    let code: String
    @ViewBuilder let preview: Preview

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title2.weight(.bold))

                Text(summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            preview
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background(.background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            DisclosureGroup {
                SampleCodeBlock(code: code)
                    .padding(.top, 8)
            } label: {
                Label("Sample code", systemImage: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline.weight(.semibold))
            }

            Divider()
        }
    }
}

private struct LayoutBlock: View {
    let title: String
    let colour: Color

    init(_ title: String, colour: Color) {
        self.title = title
        self.colour = colour
    }

    var body: some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(colour.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

private struct LayoutIcon: View {
    let symbol: String
    let colour: Color

    init(_ symbol: String, colour: Color) {
        self.symbol = symbol
        self.colour = colour
    }

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 36, height: 36)
            .background(colour.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
