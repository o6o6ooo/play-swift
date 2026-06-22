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
            NavigationBasicsCombinedSection()

            NavigationBasicsSection(
                title: "Value-based destinations",
                summary: "For lists of data, pass a value through NavigationLink and describe the matching destination once.",
                code: """
                struct Lesson: Identifiable, Hashable {
                    let id = UUID()
                    let title: String
                    let systemImage: String
                }

                let lessons = [
                    Lesson(title: "Stacks", systemImage: "square.stack.3d.up"),
                    Lesson(title: "Navigation", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                ]

                NavigationStack {
                    VStack(spacing: 8) {
                        ForEach(lessons) { lesson in
                            NavigationLink(value: lesson) {
                                HStack(spacing: 10) {
                                    Image(systemName: lesson.systemImage)
                                        .foregroundStyle(.indigo)
                                        .frame(width: 24)

                                    Text(lesson.title)
                                        .font(.subheadline.weight(.semibold))

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }
                                .padding(12)
                                .background(.quaternary, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            .buttonStyle(.plain)
                        }
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

private struct NavigationBasicsCombinedSection: View {
    private let code = """
    NavigationStack {
        VStack(spacing: 8) {
            NavigationLink {
                LessonsView()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "book")
                        .foregroundStyle(.indigo)
                        .frame(width: 24)

                    Text("Lessons")
                        .font(.subheadline.weight(.semibold))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                .padding(12)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)

            NavigationLink {
                FavouritesView()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "bookmark")
                        .foregroundStyle(.indigo)
                        .frame(width: 24)

                    Text("Favourites")
                        .font(.subheadline.weight(.semibold))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                .padding(12)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .navigationTitle("Home")
    }
    """

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("A basic navigation stack")
                .font(.title2.weight(.bold))

            VStack(alignment: .leading, spacing: 12) {
                NavigationConceptRow(
                    title: "NavigationStack",
                    summary: "The container that manages moving from one screen to another."
                )

                NavigationConceptRow(
                    title: "NavigationLink",
                    summary: "The tappable row or button that opens the next screen."
                )

                NavigationConceptRow(
                    title: ".navigationTitle",
                    summary: "The modifier that gives the current screen its title."
                )
            }

            NavigationShellPreview(title: "Home") {
                NavigationPreviewRow(title: "Lessons", symbol: "book")
                NavigationPreviewRow(title: "Favourites", symbol: "bookmark")
            }
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

private struct NavigationConceptRow: View {
    let title: String
    let summary: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(.secondary)
                .frame(width: 5, height: 5)
                .padding(.top, 8)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
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
                .foregroundStyle(.indigo)
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
