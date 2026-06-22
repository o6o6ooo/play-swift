import SwiftUI

struct AppStructureView: View {
    static let metadata = CataloguePage(
        id: "app-structure",
        title: "App Structure",
        tags: ["Basic", "SwiftUI", "App"],
        summary: "Learn the smallest useful shape of a SwiftUI app: App, WindowGroup, ContentView, and where navigation usually begins.",
        symbol: "app.connected.to.app.below.fill",
        colour: Color(hex: 0x34C759),
        destination: .appStructure
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            AppStructureDiagram()

            AppStructureSection(
                title: "The entry point",
                summary: "A SwiftUI app starts from one type marked with @main. WindowGroup creates the app window and usually shows your first view.",
                code: """
                @main
                struct PlaySwiftApp: App {
                    var body: some Scene {
                        WindowGroup {
                            ContentView()
                        }
                    }
                }
                """
            )

            AppStructureSection(
                title: "The first screen",
                summary: "ContentView is just a View. Its body describes the UI SwiftUI should render.",
                code: """
                struct ContentView: View {
                    var body: some View {
                        Text("Hello, SwiftUI")
                    }
                }
                """
            )

            AppStructureSection(
                title: "A common app shell",
                summary: "For many apps, ContentView owns the top-level navigation such as tabs, then each tab can open its own screens.",
                code: """
                struct ContentView: View {
                    var body: some View {
                        TabView {
                            NavigationStack {
                                HomeView()
                            }
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                        }
                    }
                }
                """
            )
        }
    }
}

private struct AppStructureDiagram: View {
    private let steps = [
        AppStructureStep(
            title: "@main App",
            summary: "The process starts here.",
            symbol: "app.badge",
            tint: Color(hex: 0x34C759)
        ),
        AppStructureStep(
            title: "WindowGroup",
            summary: "SwiftUI creates a window scene.",
            symbol: "macwindow",
            tint: Color(hex: 0x007AFF)
        ),
        AppStructureStep(
            title: "ContentView",
            summary: "Your first visible view appears.",
            symbol: "rectangle.inset.filled",
            tint: Color(hex: 0xFF9500)
        ),
        AppStructureStep(
            title: "Screens",
            summary: "Navigation, tabs, and child views branch out.",
            symbol: "rectangle.stack.fill",
            tint: Color(hex: 0x5856D6)
        )
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("How the pieces connect")
                .font(.title2.weight(.bold))

            VStack(alignment: .leading, spacing: 10) {
                ForEach(steps) { step in
                    AppStructureStepRow(step: step)

                    if step.id != steps.last?.id {
                        Image(systemName: "arrow.down")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.secondary)
                            .frame(width: 36)
                    }
                }
            }
        }
    }
}

private struct AppStructureStepRow: View {
    let step: AppStructureStep

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: step.symbol)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(step.tint.gradient, in: RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 3) {
                Text(step.title)
                    .font(.headline)

                Text(step.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct AppStructureStep: Identifiable {
    let id = UUID()
    let title: String
    let summary: String
    let symbol: String
    let tint: Color
}

private struct AppStructureSection: View {
    let title: String
    let summary: String
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title2.weight(.bold))

                Text(summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // A simple code block keeps this beginner page readable without extra controls yet.
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .padding(12)
            }
            .background(.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))

            Divider()
        }
    }
}
