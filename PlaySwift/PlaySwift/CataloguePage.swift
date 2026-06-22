import SwiftUI

struct CatalogueSection: Identifiable {
    // Keep the section id stable so SwiftUI can diff the home rows predictably.
    let id: String
    let title: String
    let pages: [CataloguePage]
}

struct CataloguePage: Identifiable {
    // Metadata lives beside each page view so ContentView only has to display the catalogue.
    let id: String
    let title: String
    let tags: [String]
    let summary: String
    let symbol: String
    let colour: Color
    let destination: CatalogueDestination
}

enum CatalogueDestination {
    case buttons
    case mapsBottomSheet
    case matchedGeometryCards
    case togglesAndSwitches
    case pickersAndMenus
    case listsFormsAndRows
    case musicMiniPlayer
    case photosZoomGrid
    case walletCardStack
    case liquidGlassButtons
    case newNavigationPatterns
}

extension CatalogueSection {
    // The home screen is built from metadata owned by each page view.
    static let homeSections: [CatalogueSection] = [
        CatalogueSection(
            id: "featured",
            title: "Featured",
            pages: [
                ButtonsView.metadata,
                MapsBottomSheetView.metadata,
                MatchedGeometryCardsView.metadata
            ]
        ),
        CatalogueSection(
            id: "components",
            title: "Components",
            pages: [
                TogglesAndSwitchesView.metadata,
                PickersAndMenusView.metadata,
                ListsFormsAndRowsView.metadata
            ]
        ),
        CatalogueSection(
            id: "apple-inspired",
            title: "Apple Inspired",
            pages: [
                MusicMiniPlayerView.metadata,
                PhotosZoomGridView.metadata,
                WalletCardStackView.metadata
            ]
        ),
        CatalogueSection(
            id: "ios-26-lab",
            title: "iOS 26 Lab",
            pages: [
                LiquidGlassButtonView.metadata,
                NewNavigationPatternsView.metadata
            ]
        )
    ]
}

extension CataloguePage {
    static var allPages: [CataloguePage] {
        CatalogueSection.homeSections.flatMap(\.pages)
    }
}

extension Color {
    // Small helper for using Apple-style palette values in page metadata.
    init(hex: Int) {
        self.init(
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255
        )
    }
}
