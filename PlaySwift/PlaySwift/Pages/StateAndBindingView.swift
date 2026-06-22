import SwiftUI

struct StateAndBindingView: View {
    static let metadata = CataloguePage(
        id: "state-and-binding",
        title: "State and Binding",
        tags: ["Basic", "State", "Binding"],
        summary: "Learn how @State stores local view data and @Binding lets a child view edit that data.",
        symbol: "arrow.left.arrow.right.square.fill",
        colour: Color(hex: 0xFF9500),
        destination: .stateAndBinding
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            StateAndBindingSection()
        }
    }
}

private struct StateAndBindingSection: View {
    private let code = """
    struct StateBindingExampleView: View {
        @State private var isEnabled = true

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(isEnabled ? "Notifications On" : "Notifications Off")
                    .font(.title3.weight(.bold))

                NotificationToggle(isEnabled: $isEnabled)
            }
            .padding()
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }

    struct NotificationToggle: View {
        @Binding var isEnabled: Bool

        var body: some View {
            Toggle("Allow notifications", isOn: $isEnabled)
        }
    }
    """

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                StateBindingConceptRow(
                    title: "@State",
                    summary: "A view-owned value that can change and refresh the UI."
                )

                StateBindingConceptRow(
                    title: "@Binding",
                    summary: "A connection that lets a child view read and write a value owned somewhere else."
                )
            }

            StateBindingExampleView()
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
        }
    }
}

private struct StateBindingExampleView: View {
    @State private var isEnabled = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(isEnabled ? "Notifications On" : "Notifications Off")
                .font(.title3.weight(.bold))

            NotificationToggle(isEnabled: $isEnabled)
        }
        .padding()
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct NotificationToggle: View {
    @Binding var isEnabled: Bool

    var body: some View {
        Toggle("Allow notifications", isOn: $isEnabled)
    }
}

private struct StateBindingConceptRow: View {
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
