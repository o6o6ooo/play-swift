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
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(.blue.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))

                    Text("Subtitle")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(.cyan.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))

                    Text("Continue")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(.green.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                """,
                preview: {
                    VStack(alignment: .leading, spacing: 12) {
                        LayoutBlock("Title", colour: .blue)
                        LayoutBlock("Subtitle", colour: .cyan)
                        LayoutBlock("Continue", colour: .green)
                    }
                }
            )

            LayoutBasicsSection(
                title: "HStack",
                summary: "HStack places views from leading to trailing.",
                code: """
                HStack(spacing: 12) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(.yellow.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))

                    Text("Favourite")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(.orange.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(.gray.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                """,
                preview: {
                    HStack(spacing: 12) {
                        LayoutIcon("star.fill", colour: .yellow)
                        LayoutBlock("Favourite", colour: .orange)
                        Spacer(minLength: 0)
                        LayoutIcon("chevron.right", colour: .gray)
                    }
                }
            )

            LayoutBasicsSection(
                title: "ZStack",
                summary: "ZStack layers views front to back. The topTrailing alignment places the badge in the top-right corner.",
                code: """
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.indigo.gradient)
                        .frame(height: 96)

                    Text("New")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.thinMaterial, in: Capsule())
                        .padding(10)
                }
                """,
                preview: {
                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.indigo.gradient)
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
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(.green.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))

                    Spacer()

                    Text("Trailing")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(.pink.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding(12)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .frame(maxWidth: .infinity)
                """,
                preview: {
                    HStack {
                        LayoutBlock("Leading", colour: .green)
                        Spacer()
                        LayoutBlock("Trailing", colour: .pink)
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
