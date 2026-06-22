import SwiftUI

struct ButtonBasicsView: View {
    static let metadata = CataloguePage(
        id: "button-basics",
        title: "Button Basics",
        tags: ["Basic", "Buttons", "SwiftUI"],
        summary: "Learn the core Button shapes: text buttons, label buttons, roles, disabled state, bordered styles, and control sizes.",
        symbol: "button.programmable",
        colour: Color(hex: 0xFF9500),
        destination: .buttonBasics
    )

    let isFavourite: Bool
    let toggleFavourite: () -> Void

    var body: some View {
        CataloguePageContainer(
            page: Self.metadata,
            isFavourite: isFavourite,
            toggleFavourite: toggleFavourite
        ) {
            ForEach(ButtonBasicsExample.examples) { example in
                ButtonBasicsExampleView(example: example)
            }
        }
    }
}

private struct ButtonBasicsExampleView: View {
    let example: ButtonBasicsExample

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(example.title)
                    .font(.title2.weight(.bold))

                Text(example.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            example.preview
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background(.background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            DisclosureGroup {
                SampleCodeBlock(code: example.code)
                    .padding(.top, 8)
            } label: {
                Label("Sample code", systemImage: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline.weight(.semibold))
            }

            Divider()
        }
    }
}

private struct ButtonBasicsExample: Identifiable {
    let id = UUID()
    let title: String
    let summary: String
    let code: String
    let preview: AnyView

    init<Preview: View>(
        title: String,
        summary: String,
        code: String,
        @ViewBuilder preview: () -> Preview
    ) {
        self.title = title
        self.summary = summary
        self.code = code
        self.preview = AnyView(preview())
    }
}

private extension ButtonBasicsExample {
    static let examples: [ButtonBasicsExample] = [
        ButtonBasicsExample(
            title: "Text button",
            summary: "The simplest button uses a text title and an action closure.",
            code: """
            Button("Continue") {
                // Continue to the next step.
            }
            """
        ) {
            Button("Continue") {
            }
        },
        ButtonBasicsExample(
            title: "Label button",
            summary: "Use Label when the button should show both text and an SF Symbol.",
            code: """
            Button {
                // Save the item.
            } label: {
                Label("Save", systemImage: "tray.and.arrow.down")
            }
            """
        ) {
            Button {
            } label: {
                Label("Save", systemImage: "tray.and.arrow.down")
            }
        },
        ButtonBasicsExample(
            title: "Button roles",
            summary: "Roles describe the meaning of an action. SwiftUI can use them for colour, menus, alerts, and accessibility.",
            code: """
            HStack {
                Button("Confirm", role: .confirm) {
                    // Confirm the user's choice.
                }

                Button("Delete", role: .destructive) {
                    // Delete the item.
                }
            }
            .buttonStyle(.borderedProminent)
            """
        ) {
            HStack {
                Button("Confirm", role: .confirm) {
                }

                Button("Delete", role: .destructive) {
                }
            }
            .buttonStyle(.borderedProminent)
        },
        ButtonBasicsExample(
            title: "Disabled button",
            summary: "Disabled buttons stay visible but cannot be pressed.",
            code: """
            Button("Unavailable") {
                // This action is currently unavailable.
            }
            .buttonStyle(.bordered)
            .disabled(true)
            """
        ) {
            Button("Unavailable") {
            }
            .buttonStyle(.bordered)
            .disabled(true)
        },
        ButtonBasicsExample(
            title: "Bordered styles",
            summary: "Bordered styles give buttons stronger visual structure without custom drawing.",
            code: """
            HStack {
                Button("Cancel") {
                    // Cancel the action.
                }
                .buttonStyle(.bordered)

                Button("Done") {
                    // Finish the action.
                }
                .buttonStyle(.borderedProminent)
            }
            """
        ) {
            HStack {
                Button("Cancel") {
                }
                .buttonStyle(.bordered)

                Button("Done") {
                }
                .buttonStyle(.borderedProminent)
            }
        },
        ButtonBasicsExample(
            title: "Control size",
            summary: "controlSize changes the standard size of supported controls.",
            code: """
            HStack {
                Button("Small") {
                    // Small action.
                }
                .controlSize(.small)

                Button("Large") {
                    // Large action.
                }
                .controlSize(.large)
            }
            .buttonStyle(.bordered)
            """
        ) {
            HStack {
                Button("Small") {
                }
                .controlSize(.small)

                Button("Large") {
                }
                .controlSize(.large)
            }
            .buttonStyle(.bordered)
        }
    ]
}
