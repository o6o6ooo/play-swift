import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct SampleCodeBlock: View {
    let code: String

    @State private var didCopy = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .padding(12)
                    .padding(.trailing, 44)
            }
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))

            Button {
                copyCode()
            } label: {
                Image(systemName: didCopy ? "checkmark" : "doc.on.doc")
                    .font(.caption.weight(.semibold))
                    .frame(width: 16, height: 16)
            }
            .buttonStyle(.glass(.clear))
            .buttonBorderShape(.circle)
            .controlSize(.mini)
            .padding(.top, 6)
            .padding(.trailing, 6)
            .accessibilityLabel(didCopy ? "Copied" : "Copy")
        }
    }

    private func copyCode() {
        Clipboard.copy(code)

        withAnimation(.snappy) {
            didCopy = true
        }

        Task {
            try? await Task.sleep(for: .seconds(1.2))

            withAnimation(.snappy) {
                didCopy = false
            }
        }
    }
}

private enum Clipboard {
    static func copy(_ text: String) {
        // Use Apple's platform pasteboard APIs while the visible UI stays SwiftUI-native.
        #if canImport(UIKit)
        UIPasteboard.general.string = text
        #elseif canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        #endif
    }
}
