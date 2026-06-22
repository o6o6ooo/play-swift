import SwiftUI

struct ContentView: View {
    @State private var selectedTab = AppTab.discover
    // The search text lives at the root so the search tab and result list share one source of truth.
    @State private var searchText = ""
    @State private var favouriteIDs: Set<CataloguePage.ID> = []

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Discover", systemImage: "square.grid.2x2.fill", value: AppTab.discover) {
                DiscoverView(favouriteIDs: $favouriteIDs)
            }

            Tab("Favourites", systemImage: "bookmark.fill", value: AppTab.favourites) {
                FavouritesView(favouriteIDs: $favouriteIDs)
            }

            // A search role lets SwiftUI render the system search tab style on supported iOS versions.
            Tab(value: AppTab.search, role: .search) {
                SearchView(searchText: $searchText, favouriteIDs: $favouriteIDs)
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
    @Binding var favouriteIDs: Set<CataloguePage.ID>

    private let sections = CatalogueSection.homeSections

    var body: some View {
        NavigationStack {
            ScrollView {
                // LazyVStack keeps off-screen sections lightweight as the catalogue grows.
                LazyVStack(alignment: .leading, spacing: 28) {
                    ForEach(sections) { section in
                        CatalogueSectionView(section: section, favouriteIDs: $favouriteIDs)
                    }
                }
                .padding(.vertical, 18)
            }
            .navigationTitle("Discover")
            .background(.background)
        }
    }
}

private struct SearchView: View {
    @Binding var searchText: String
    @Binding var favouriteIDs: Set<CataloguePage.ID>

    private var displayedSections: [CatalogueSection] {
        // Trim whitespace so a blank-looking query behaves like an empty search.
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard query.isEmpty == false else {
            return CatalogueSection.homeSections
        }

        // Search across the visible text a user would naturally expect to match.
        let matches = CataloguePage.allPages
            .filter { page in
                page.title.localizedCaseInsensitiveContains(query)
                || page.summary.localizedCaseInsensitiveContains(query)
                || page.tags.contains { $0.localizedCaseInsensitiveContains(query) }
            }

        return [
            CatalogueSection(id: "search-results", title: "Search results", pages: matches)
        ]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                // ContentUnavailableView gives us Apple's standard empty-search treatment.
                if displayedSections.allSatisfy(\.pages.isEmpty) {
                    ContentUnavailableView.search(text: searchText)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 96)
                } else {
                    LazyVStack(alignment: .leading, spacing: 28) {
                        ForEach(displayedSections) { section in
                            CatalogueSectionView(section: section, favouriteIDs: $favouriteIDs)
                        }
                    }
                    .padding(.vertical, 18)
                }
            }
            .navigationTitle("Search")
            .background(.background)
            .searchable(text: $searchText, prompt: "Search PlaySwift")
        }
    }
}

private struct CatalogueSectionView: View {
    let section: CatalogueSection
    @Binding var favouriteIDs: Set<CataloguePage.ID>

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
                    ForEach(section.pages) { page in
                        NavigationLink {
                            CatalogueDestinationView(page: page, favouriteIDs: $favouriteIDs)
                        } label: {
                            CatalogueCard(page: page)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

private struct CatalogueDestinationView: View {
    let page: CataloguePage
    @Binding var favouriteIDs: Set<CataloguePage.ID>

    var body: some View {
        // ContentView chooses a destination; each page owns its own metadata and body.
        switch page.destination {
        case .appStructure:
            AppStructureView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .buttons:
            ButtonsView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .mapsBottomSheet:
            MapsBottomSheetView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .matchedGeometryCards:
            MatchedGeometryCardsView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .togglesAndSwitches:
            TogglesAndSwitchesView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .pickersAndMenus:
            PickersAndMenusView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .listsFormsAndRows:
            ListsFormsAndRowsView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .musicMiniPlayer:
            MusicMiniPlayerView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .photosZoomGrid:
            PhotosZoomGridView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .walletCardStack:
            WalletCardStackView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .liquidGlassButtons:
            LiquidGlassButtonView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        case .newNavigationPatterns:
            NewNavigationPatternsView(isFavourite: isFavourite, toggleFavourite: toggleFavourite)
        }
    }

    private var isFavourite: Bool {
        favouriteIDs.contains(page.id)
    }

    private func toggleFavourite() {
        if favouriteIDs.contains(page.id) {
            favouriteIDs.remove(page.id)
        } else {
            favouriteIDs.insert(page.id)
        }
    }
}

private struct CatalogueCard: View {
    let page: CataloguePage

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ThumbnailView(page: page)

            Text(page.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .frame(width: 120, alignment: .leading)
        }
        .frame(width: 120, alignment: .topLeading)
    }
}

private struct ThumbnailView: View {
    let page: CataloguePage

    var body: some View {
        ZStack {
            // The thumbnails are placeholders until real component previews are added.
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            page.colour.opacity(0.92),
                            page.colour.opacity(0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Image(systemName: page.symbol)
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.22), radius: 8, y: 4)
        }
        .frame(width: 120, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct FavouritesView: View {
    @Binding var favouriteIDs: Set<CataloguePage.ID>

    private var favouritePages: [CataloguePage] {
        CataloguePage.allPages
            .filter { favouriteIDs.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            if favouritePages.isEmpty {
                ContentUnavailableView(
                    "No Favourites Yet",
                    systemImage: "bookmark",
                    description: Text("Bookmark SwiftUI examples to keep them here.")
                )
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 132), spacing: 16)],
                        alignment: .leading,
                        spacing: 20
                    ) {
                        ForEach(favouritePages) { page in
                            NavigationLink {
                                CatalogueDestinationView(page: page, favouriteIDs: $favouriteIDs)
                            } label: {
                                CatalogueCard(page: page)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("Favourites")
    }
}
