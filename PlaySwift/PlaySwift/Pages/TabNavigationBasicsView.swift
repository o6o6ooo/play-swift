import SwiftUI

struct TabNavigationBasicsView: View {
    static let metadata = CataloguePage(
        id: "tab-navigation-basics",
        title: "Tab Navigation Basics",
        tags: ["Basic", "Navigation", "Tabs"],
        summary: "Learn how TabView switches between the main areas of an app, and how each tab can own its own NavigationStack.",
        symbol: "rectangle.bottomthird.inset.filled",
        colour: Color(hex: 0x007AFF),
        destination: .tabNavigationBasics
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            TabNavigationSection()
        }
    }
}

private struct TabNavigationSection: View {
    private let code = """
    struct TabExampleView: View {
        var body: some View {
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    NavigationStack {
                        Text("Home")
                            .font(.title.weight(.bold))
                            .navigationTitle("Home")
                    }
                }

                Tab("Settings", systemImage: "gearshape.fill") {
                    NavigationStack {
                        Text("Settings")
                            .font(.title.weight(.bold))
                            .navigationTitle("Settings")
                    }
                }
            }
            .frame(height: 260)
        }
    }
    """

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tabs organise top-level areas")
                .font(.title2.weight(.bold))

            VStack(alignment: .leading, spacing: 12) {
                TabNavigationConceptRow(
                    title: "TabView",
                    summary: "The container that switches between the main areas of the app."
                )

                TabNavigationConceptRow(
                    title: "Tab",
                    summary: "One item in the tab bar, with its own label, symbol, value, and content."
                )

                TabNavigationConceptRow(
                    title: "NavigationStack",
                    summary: "Each tab can own a separate navigation stack for pushing detail screens."
                )
            }

            TabExampleView()
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

private struct TabExampleView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    Text("Home")
                        .font(.title.weight(.bold))
                        .navigationTitle("Home")
                }
            }

            Tab("Settings", systemImage: "gearshape.fill") {
                NavigationStack {
                    Text("Settings")
                        .font(.title.weight(.bold))
                        .navigationTitle("Settings")
                }
            }
        }
        .frame(height: 260)
    }
}

private struct TabNavigationConceptRow: View {
    let title: String
    let summary: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(.primary)
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
