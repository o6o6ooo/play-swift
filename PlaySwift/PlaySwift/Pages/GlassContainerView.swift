import SwiftUI

struct GlassContainerView: View {
    static let metadata = CataloguePage(
        id: "glass-container-comparison",
        title: "Glass Container",
        tags: ["Liquid Glass", "Materials", "iOS 26"],
        summary: "Compare clear and regular Liquid Glass with all five SwiftUI material thicknesses on large cards.",
        symbol: "rectangle.stack.fill",
        colour: Color(hex: 0xAF52DE),
        destination: .glassContainerComparison
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Seven translucent surfaces")
                        .font(.title2.weight(.bold))

                    Text("Each card uses the same size and content so you can focus on how the surface responds to the colourful background.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                GlassContainerComparisonPreview()

                DisclosureGroup {
                    SampleCodeBlock(code: Self.sampleCode)
                        .padding(.top, 8)
                } label: {
                    Label("Sample code", systemImage: "chevron.left.forwardslash.chevron.right")
                        .font(.subheadline.weight(.semibold))
                }
            }
        }
    }
}

private struct GlassContainerComparisonPreview: View {
    var body: some View {
        VStack(spacing: 18) {
            ComparisonCard(
                title: "Clear Glass",
                modifier: ".glassEffect(.clear, in: .rect)"
            )
            .glassEffect(.clear, in: .rect(cornerRadius: 28))

            ComparisonCard(
                title: "Regular Glass",
                modifier: ".glassEffect(.regular, in: .rect)"
            )
            .glassEffect(.regular, in: .rect(cornerRadius: 28))

            ComparisonCard(
                title: "Ultra Thin Material",
                modifier: ".background(.ultraThinMaterial)"
            )
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 28))

            ComparisonCard(
                title: "Thin Material",
                modifier: ".background(.thinMaterial)"
            )
            .background(.thinMaterial, in: .rect(cornerRadius: 28))

            ComparisonCard(
                title: "Regular Material",
                modifier: ".background(.regularMaterial)"
            )
            .background(.regularMaterial, in: .rect(cornerRadius: 28))

            ComparisonCard(
                title: "Thick Material",
                modifier: ".background(.thickMaterial)"
            )
            .background(.thickMaterial, in: .rect(cornerRadius: 28))

            ComparisonCard(
                title: "Ultra Thick Material",
                modifier: ".background(.ultraThickMaterial)"
            )
            .background(.ultraThickMaterial, in: .rect(cornerRadius: 28))
        }
        .padding(16)
        .background {
            ComparisonBackdrop()
        }
        .clipShape(.rect(cornerRadius: 32))
    }
}

private struct ComparisonCard: View {
    let title: String
    let modifier: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "sparkles.rectangle.stack.fill")
                .font(.title2)

            Spacer(minLength: 28)

            Text(title)
                .font(.title3.weight(.bold))

            Text(modifier)
                .font(.caption.monospaced())
                .foregroundStyle(.white.opacity(0.8))
        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 168, alignment: .leading)
    }
}

private struct ComparisonBackdrop: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(.cyan)
                .frame(width: 210, height: 210)
                .blur(radius: 8)
                .offset(x: 120, y: -260)

            Circle()
                .fill(.pink)
                .frame(width: 240, height: 240)
                .blur(radius: 12)
                .offset(x: -130, y: 150)

            Image(systemName: "circle.hexagongrid.fill")
                .font(.system(size: 190))
                .foregroundStyle(.white.opacity(0.18))
                .rotationEffect(.degrees(-12))
                .offset(x: 100, y: 330)
        }
    }
}

private extension GlassContainerView {
    static let sampleCode = """
    import SwiftUI

    struct GlassContainerComparison: View {
        var body: some View {
            VStack(spacing: 18) {
                ComparisonCard(
                    title: "Clear Glass",
                    modifier: ".glassEffect(.clear, in: .rect)"
                )
                .glassEffect(.clear, in: .rect(cornerRadius: 28))

                ComparisonCard(
                    title: "Regular Glass",
                    modifier: ".glassEffect(.regular, in: .rect)"
                )
                .glassEffect(.regular, in: .rect(cornerRadius: 28))

                ComparisonCard(
                    title: "Ultra Thin Material",
                    modifier: ".background(.ultraThinMaterial)"
                )
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 28))

                ComparisonCard(
                    title: "Thin Material",
                    modifier: ".background(.thinMaterial)"
                )
                .background(.thinMaterial, in: .rect(cornerRadius: 28))

                ComparisonCard(
                    title: "Regular Material",
                    modifier: ".background(.regularMaterial)"
                )
                .background(.regularMaterial, in: .rect(cornerRadius: 28))

                ComparisonCard(
                    title: "Thick Material",
                    modifier: ".background(.thickMaterial)"
                )
                .background(.thickMaterial, in: .rect(cornerRadius: 28))

                ComparisonCard(
                    title: "Ultra Thick Material",
                    modifier: ".background(.ultraThickMaterial)"
                )
                .background(.ultraThickMaterial, in: .rect(cornerRadius: 28))
            }
            .padding(16)
            .background {
                ComparisonBackdrop()
            }
            .clipShape(.rect(cornerRadius: 32))
        }
    }

    private struct ComparisonCard: View {
        let title: String
        let modifier: String

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "sparkles.rectangle.stack.fill")
                    .font(.title2)

                Spacer(minLength: 28)

                Text(title)
                    .font(.title3.weight(.bold))

                Text(modifier)
                    .font(.caption.monospaced())
                    .foregroundStyle(.white.opacity(0.8))
            }
            .foregroundStyle(.white)
            .padding(24)
            .frame(maxWidth: .infinity, minHeight: 168, alignment: .leading)
        }
    }

    private struct ComparisonBackdrop: View {
        var body: some View {
            ZStack {
                LinearGradient(
                    colors: [.indigo, .blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Circle()
                    .fill(.cyan)
                    .frame(width: 210, height: 210)
                    .blur(radius: 8)
                    .offset(x: 120, y: -260)

                Circle()
                    .fill(.pink)
                    .frame(width: 240, height: 240)
                    .blur(radius: 12)
                    .offset(x: -130, y: 150)

                Image(systemName: "circle.hexagongrid.fill")
                    .font(.system(size: 190))
                    .foregroundStyle(.white.opacity(0.18))
                    .rotationEffect(.degrees(-12))
                    .offset(x: 100, y: 330)
            }
        }
    }
    """
}
