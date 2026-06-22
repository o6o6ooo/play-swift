import SwiftUI

struct NavigationBasicsView: View {
    static let metadata = CataloguePage(
        id: "navigation-basics",
        title: "Navigation Basics",
        tags: ["Basic", "Navigation", "SwiftUI"],
        summary: "Learn how NavigationStack, NavigationLink, navigation titles, and value-based destinations build a SwiftUI navigation flow.",
        symbol: "point.topleft.down.curvedto.point.bottomright.up",
        colour: Color(hex: 0x5856D6),
        destination: .navigationBasics
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            NavigationFlowDiagram()

            NavigationBasicsSection(
                title: "NavigationStack",
                summary: "NavigationStack is the container that lets screens push deeper views.",
                code: """
                NavigationStack {
                    List {
                        NavigationLink("Lessons") {
                            LessonsView()
                        }

                        NavigationLink("Favourites") {
                            FavouritesView()
                        }
                    }
                    .navigationTitle("Home")
                }
                """,
                preview: {
                    NavigationShellPreview(title: "Home") {
                        NavigationPreviewRow(title: "Lessons", symbol: "book")
                        NavigationPreviewRow(title: "Favourites", symbol: "bookmark")
                    }
                }
            )

            NavigationBasicsSection(
                title: "NavigationLink",
                summary: "NavigationLink shows tappable UI that opens another view when selected.",
                code: """
                NavigationLink {
                    DetailView()
                } label: {
                    Label("Open Detail", systemImage: "chevron.right")
                }
                """,
                preview: {
                    NavigationPreviewRow(title: "Open Detail", symbol: "chevron.right")
                }
            )

            NavigationBasicsSection(
                title: "Navigation title",
                summary: "navigationTitle sets the title for the current screen inside a navigation stack.",
                code: """
                NavigationStack {
                    List {
                        Text("First row")
                        Text("Second row")
                    }
                    .navigationTitle("Components")
                }
                """,
                preview: {
                    NavigationShellPreview(title: "Components") {
                        NavigationPreviewRow(title: "First row", symbol: "1.circle")
                        NavigationPreviewRow(title: "Second row", symbol: "2.circle")
                    }
                }
            )

            NavigationBasicsSection(
                title: "Value-based destinations",
                summary: "For lists of data, pass a value through NavigationLink and describe the matching destination once.",
                code: """
                struct Lesson: Identifiable, Hashable {
                    let id = UUID()
                    let title: String
                }

                NavigationStack {
                    List(lessons) { lesson in
                        NavigationLink(lesson.title, value: lesson)
                    }
                    .navigationDestination(for: Lesson.self) { lesson in
                        LessonDetailView(lesson: lesson)
                    }
                }
                """,
                preview: {
                    ValueNavigationPreview()
                }
            )
        }
    }
}

private struct NavigationFlowDiagram: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("A simple navigation flow")
                .font(.title2.weight(.bold))

            HStack(spacing: 10) {
                NavigationFlowNode(title: "List", symbol: "list.bullet", colour: Color(hex: 0x007AFF))

                Image(systemName: "arrow.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                NavigationFlowNode(title: "Detail", symbol: "doc.text", colour: Color(hex: 0x5856D6))

                Image(systemName: "arrow.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                NavigationFlowNode(title: "More", symbol: "ellipsis", colour: Color(hex: 0xFF9500))
            }
        }
    }
}

private struct NavigationFlowNode: View {
    let title: String
    let symbol: String
    let colour: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: symbol)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(colour.gradient, in: RoundedRectangle(cornerRadius: 12, style: .continuous))

            Text(title)
                .font(.caption.weight(.semibold))
        }
        .frame(maxWidth: .infinity)
    }
}

private struct NavigationBasicsSection<Preview: View>: View {
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

private struct NavigationShellPreview<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)

                Spacer()

                Image(systemName: "chevron.left")
                    .foregroundStyle(.tertiary)
            }

            VStack(spacing: 8) {
                content
            }
        }
    }
}

private struct NavigationPreviewRow: View {
    let title: String
    let symbol: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .foregroundStyle(Color(hex: 0x5856D6))
                .frame(width: 24)

            Text(title)
                .font(.subheadline.weight(.semibold))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct ValueNavigationPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                NavigationPreviewRow(title: "Stacks", symbol: "square.stack.3d.up")
                NavigationPreviewRow(title: "Navigation", symbol: "point.topleft.down.curvedto.point.bottomright.up")
            }

            HStack(spacing: 10) {
                NavigationValuePill("Lesson")

                Image(systemName: "arrow.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                NavigationValuePill("LessonDetailView")
            }

            Text("The row passes a Lesson value into LessonDetailView.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct NavigationValuePill: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(Color(hex: 0x5856D6).gradient, in: Capsule())
    }
}
