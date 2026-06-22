import SwiftUI

struct ContentView: View {
    @State private var selectedTab = AppTab.discover
    // The search text lives at the root so the search tab and result list share one source of truth.
    @State private var searchText = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Discover", systemImage: "square.grid.2x2.fill", value: AppTab.discover) {
                DiscoverView()
            }

            Tab("Favourites", systemImage: "bookmark.fill", value: AppTab.favourites) {
                FavouritesView()
            }

            // A search role lets SwiftUI render the system search tab style on supported iOS versions.
            Tab(value: AppTab.search, role: .search) {
                SearchView(searchText: $searchText)
            }
        }
        // Activates search when the user selects the search tab.
        .tabViewSearchActivation(.searchTabSelection)
    }
}

private enum AppTab: Hashable {
    case discover
    case favourites
    case search
}

private struct DiscoverView: View {
    // For now the catalogue is in-memory sample data. Later this can move to a dedicated model file.
    private let sections = CatalogueSection.sampleSections

    var body: some View {
        NavigationStack {
            ScrollView {
                // LazyVStack keeps off-screen sections lightweight as the catalogue grows.
                LazyVStack(alignment: .leading, spacing: 28) {
                    ForEach(sections) { section in
                        CatalogueSectionView(section: section)
                    }
                }
                .padding(.vertical, 18)
            }
            .navigationTitle("Discover")
            .background(Color(.systemGroupedBackground))
        }
    }
}

private struct SearchView: View {
    @Binding var searchText: String

    private var displayedSections: [CatalogueSection] {
        // Trim whitespace so a blank-looking query behaves like an empty search.
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard query.isEmpty == false else {
            return CatalogueSection.sampleSections
        }

        // Search across the visible text a user would naturally expect to match.
        let matches = CatalogueSection.sampleSections
            .flatMap(\.items)
            .filter { item in
                item.title.localizedCaseInsensitiveContains(query)
                || item.category.localizedCaseInsensitiveContains(query)
                || item.summary.localizedCaseInsensitiveContains(query)
            }

        return [
            CatalogueSection(title: "Search results", items: matches)
        ]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                // ContentUnavailableView gives us Apple's standard empty-search treatment.
                if displayedSections.allSatisfy(\.items.isEmpty) {
                    ContentUnavailableView.search(text: searchText)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 96)
                } else {
                    LazyVStack(alignment: .leading, spacing: 28) {
                        ForEach(displayedSections) { section in
                            CatalogueSectionView(section: section)
                        }
                    }
                    .padding(.vertical, 18)
                }
            }
            .navigationTitle("Search")
            .background(Color(.systemGroupedBackground))
            .searchable(text: $searchText, prompt: "Search PlaySwift")
        }
    }
}

private struct CatalogueSectionView: View {
    let section: CatalogueSection

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Section titles mirror Apple's article-style browse pages.
            HStack(spacing: 6) {
                Text(section.title)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.primary)

                Image(systemName: "chevron.right")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                // Horizontal rows keep each section scannable without leaving the home screen.
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(section.items) { item in
                        NavigationLink {
                            CatalogueDetailView(item: item)
                        } label: {
                            CatalogueCard(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

private struct CatalogueCard: View {
    let item: CatalogueItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ThumbnailView(item: item)

            Text(item.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .frame(width: 132, alignment: .leading)
        }
        .frame(width: 132, alignment: .topLeading)
    }
}

private struct ThumbnailView: View {
    let item: CatalogueItem

    var body: some View {
        ZStack {
            // The thumbnails are placeholders until real component previews are added.
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            item.colour.opacity(0.92),
                            item.colour.opacity(0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Image(systemName: item.symbol)
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.22), radius: 8, y: 4)
        }
        .frame(width: 132, height: 132)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct CatalogueDetailView: View {
    let item: CatalogueItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Reuse the card thumbnail so the detail page feels connected to the catalogue.
                ThumbnailView(item: item)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 8) {
                    Text(item.category)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(item.colour)

                    Text(item.title)
                        .font(.largeTitle.weight(.bold))

                    Text(item.summary)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

private struct FavouritesView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Favourites Yet",
                systemImage: "bookmark",
                description: Text("Bookmark SwiftUI examples to keep them here.")
            )
            .navigationTitle("Favourites")
        }
    }
}

private struct CatalogueSection: Identifiable {
    // Identifiable lets ForEach diff sections without manual id parameters.
    let id = UUID()
    let title: String
    let items: [CatalogueItem]
}

private struct CatalogueItem: Identifiable {
    // Each item represents one future interactive SwiftUI demo.
    let id = UUID()
    let title: String
    let category: String
    let summary: String
    let symbol: String
    let colour: Color
}

private extension CatalogueSection {
    // Seed content keeps the first screen useful before real demos are implemented.
    static let sampleSections: [CatalogueSection] = [
        CatalogueSection(
            title: "Featured",
            items: [
                CatalogueItem(
                    title: "Buttons that feel native",
                    category: "Components",
                    summary: "Compare prominent, bordered, destructive, menu-backed, and animated button styles.",
                    symbol: "button.programmable",
                    colour: Color(hex: 0x007AFF)
                ),
                CatalogueItem(
                    title: "Maps-style bottom sheet",
                    category: "Apple Inspired",
                    summary: "Explore detents, grabbers, search panels, and floating controls in a Maps-inspired layout.",
                    symbol: "map.fill",
                    colour: Color(hex: 0x34C759)
                ),
                CatalogueItem(
                    title: "Matched geometry cards",
                    category: "Animations",
                    summary: "Open compact cards into detail screens with a smooth shared-element transition.",
                    symbol: "rectangle.stack.fill",
                    colour: Color(hex: 0xFF2D55)
                )
            ]
        ),
        CatalogueSection(
            title: "Components",
            items: [
                CatalogueItem(
                    title: "Toggles and switches",
                    category: "Controls",
                    summary: "Inspect tinting, labels, disabled states, and settings-style toggle rows.",
                    symbol: "switch.2",
                    colour: Color(hex: 0x32ADE6)
                ),
                CatalogueItem(
                    title: "Pickers and menus",
                    category: "Controls",
                    summary: "Try segmented controls, inline pickers, wheel pickers, menus, and selection states.",
                    symbol: "filemenu.and.selection",
                    colour: Color(hex: 0xFF9500)
                ),
                CatalogueItem(
                    title: "Lists, forms, and rows",
                    category: "Lists & Layout",
                    summary: "Study grouped lists, form sections, swipe actions, and disclosure patterns.",
                    symbol: "list.bullet.rectangle.fill",
                    colour: Color(hex: 0x5856D6)
                )
            ]
        ),
        CatalogueSection(
            title: "Apple Inspired",
            items: [
                CatalogueItem(
                    title: "Music mini player",
                    category: "Music",
                    summary: "Recreate the compact player, queue entry point, and expansion transition.",
                    symbol: "music.note.list",
                    colour: Color(hex: 0xFF2D55)
                ),
                CatalogueItem(
                    title: "Photos zoom grid",
                    category: "Photos",
                    summary: "Build a photo grid that zooms into a detail view with gesture-driven dismissal.",
                    symbol: "photo.on.rectangle.angled",
                    colour: Color(hex: 0x5AC8FA)
                ),
                CatalogueItem(
                    title: "Wallet card stack",
                    category: "Wallet",
                    summary: "Experiment with stacked cards, depth, scrolling, and tap-to-expand interactions.",
                    symbol: "creditcard.fill",
                    colour: Color(hex: 0xFFCC00)
                )
            ]
        ),
        CatalogueSection(
            title: "iOS 26 Lab",
            items: [
                CatalogueItem(
                    title: "Liquid Glass buttons",
                    category: "Liquid Glass",
                    summary: "Collect experiments with the latest materials, controls, and glass-style affordances.",
                    symbol: "sparkles",
                    colour: Color(hex: 0x007AFF)
                ),
                CatalogueItem(
                    title: "New navigation patterns",
                    category: "Navigation",
                    summary: "Prototype current tab, toolbar, and split-view ideas as the platform evolves.",
                    symbol: "sidebar.leading",
                    colour: Color(hex: 0x5856D6)
                )
            ]
        )
    ]
}

private extension Color {
    // Small helper for using the Apple-style palette from the project notes.
    init(hex: Int) {
        self.init(
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255
        )
    }
}

#Preview {
    ContentView()
}
