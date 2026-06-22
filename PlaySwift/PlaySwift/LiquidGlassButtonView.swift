import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct LiquidGlassButtonView: View {
    private let sections = GlassButtonExampleSection.sections

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 28) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Components")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.blue)

                    Text("Liquid Glass Buttons")
                        .font(.largeTitle.weight(.bold))

                    Text("Button styles control appearance. Button roles describe the meaning of an action. Expand each example to inspect and copy the source.")
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)

                ForEach(sections) { section in
                    GlassButtonExampleSectionView(section: section)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
        }
        .navigationTitle("Liquid Glass Buttons")
        .navigationBarTitleDisplayMode(.inline)
        .background(.background)
    }
}

private struct GlassButtonExampleSectionView: View {
    let section: GlassButtonExampleSection

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 6) {
                Text(section.title)
                    .font(.title2.weight(.bold))

                Text(section.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ForEach(section.examples) { example in
                GlassButtonExampleView(example: example)
            }
        }
    }
}

private struct GlassButtonExampleView: View {
    let example: GlassButtonExample

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(example.title)
                    .font(.headline)

                Text(example.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            example.preview
                .frame(maxWidth: .infinity, alignment: .leading)

            DisclosureGroup {
                CodeBlock(code: example.code)
                    .padding(.top, 8)
            } label: {
                Label("Sample code", systemImage: "chevron.left.forwardslash.chevron.right")
                    .font(.subheadline.weight(.semibold))
            }

            Divider()
        }
    }
}

private struct CodeBlock: View {
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Swift")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)

                Spacer()

                Button {
                    Clipboard.copy(code)
                } label: {
                    Image(systemName: "doc.on.doc")
                        .padding(8)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Copy")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .padding(12)
            }
            .background(.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct GlassButtonExampleSection: Identifiable {
    let id = UUID()
    let title: String
    let summary: String
    let examples: [GlassButtonExample]
}

private struct GlassButtonExample: Identifiable {
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

private extension GlassButtonExampleSection {
    static let sections: [GlassButtonExampleSection] = [
        GlassButtonExampleSection(
            title: "Styles",
            summary: "Styles change how a button looks.",
            examples: GlassButtonExample.styleExamples
        ),
        GlassButtonExampleSection(
            title: "Roles",
            summary: "Roles describe what an action means to the system.",
            examples: GlassButtonExample.roleExamples
        )
    ]
}

private extension GlassButtonExample {
    static let styleExamples: [GlassButtonExample] = [
        GlassButtonExample(
            title: "Glass",
            summary: "The default glass button style for standard actions.",
            code: """
            Button("Continue") {
                // Perform the primary action.
            }
            .buttonStyle(.glass)
            """
        ) {
            Button("Continue") {
            }
            .buttonStyle(.glass)
        },
        GlassButtonExample(
            title: "Prominent Glass",
            summary: "A stronger glass treatment for the most important action in a group. Its colour follows the app accent colour or the nearest tint.",
            code: """
            Button("Start Lesson") {
                // Start the selected lesson.
            }
            .buttonStyle(.glassProminent)
            """
        ) {
            Button("Start Lesson") {
            }
            .buttonStyle(.glassProminent)
        },
        GlassButtonExample(
            title: "Tinted Glass",
            summary: "A glass button tinted with a semantic colour.",
            code: """
            Button("Save Example") {
                // Save this example.
            }
            .buttonStyle(.glass(.regular.tint(.blue)))
            """
        ) {
            Button("Save Example") {
            }
            .buttonStyle(.glass(.regular.tint(.blue)))
        },
        GlassButtonExample(
            title: "Clear Glass",
            summary: "A lighter glass style for compact controls and secondary actions.",
            code: """
            Button {
                // Open more actions.
            } label: {
                Label("More", systemImage: "ellipsis")
            }
            .buttonStyle(.glass(.clear))
            """
        ) {
            Button {
            } label: {
                Label("More", systemImage: "ellipsis")
            }
            .buttonStyle(.glass(.clear))
        },
        GlassButtonExample(
            title: "Icon Glass",
            summary: "A compact icon-only button using the same system glass style.",
            code: """
            Button {
                // Mark as favourite.
            } label: {
                Image(systemName: "heart.fill")
            }
            .buttonStyle(.glass)
            """
        ) {
            Button {
            } label: {
                Image(systemName: "heart.fill")
            }
            .buttonStyle(.glass)
        },
        GlassButtonExample(
            title: "Disabled Glass",
            summary: "The standard disabled state for a glass button.",
            code: """
            Button("Unavailable") {
                // This action is currently unavailable.
            }
            .buttonStyle(.glass)
            .disabled(true)
            """
        ) {
            Button("Unavailable") {
            }
            .buttonStyle(.glass)
            .disabled(true)
        }
    ]

    static let roleExamples: [GlassButtonExample] = [
        GlassButtonExample(
            title: "Confirm Role",
            summary: "The confirm role marks a positive confirmation action.",
            code: """
            Button("Confirm", role: .confirm) {
                // Confirm the user's choice.
            }
            .buttonStyle(.glassProminent)
            """
        ) {
            Button("Confirm", role: .confirm) {
            }
            .buttonStyle(.glassProminent)
        },
        GlassButtonExample(
            title: "Destructive Role",
            summary: "The destructive role marks delete or discard actions.",
            code: """
            Button("Delete", role: .destructive) {
                // Delete the item.
            }
            .buttonStyle(.glassProminent)
            """
        ) {
            Button("Delete", role: .destructive) {
            }
            .buttonStyle(.glassProminent)
        }
    ]
}

private enum Clipboard {
    static func copy(_ text: String) {
        // Copy uses Apple's platform pasteboard APIs while the UI stays SwiftUI-native.
        #if canImport(UIKit)
        UIPasteboard.general.string = text
        #elseif canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        #endif
    }
}

#Preview {
    NavigationStack {
        LiquidGlassButtonView()
    }
}
