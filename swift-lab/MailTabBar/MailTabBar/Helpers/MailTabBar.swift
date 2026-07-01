//
//  MailTabBar.swift
//  MailTabBar
//
//  Created by Sakura Wallace on 29/06/2026.
//

import SwiftUI

protocol MailTabItem: CaseIterable, Equatable, Hashable {
	var symbol: String { get }
	var title: String { get }
	var activeTint: Color { get }
	var activeBackground: Color { get }
}

struct MailTabBar<Tab: MailTabItem>: View {
	var spacing: CGFloat = 8
	var trailingVisibility: CGFloat = 15
	var isGestureEnabled: Bool = false
	@Binding var selection: Tab
	@State private var tabTitleSize: [Tab: CGSize] = [:]
	@State private var previousTab: Tab?
	var body: some View {
		let isLastTabActive: Bool = selection == allTabs.last

		GeometryReader {
			let containerSize = $0.size
			let activeTitleWidth: CGFloat = tabTitleSize[selection]?.width ?? 0
			// Symbol 20, Horizontal padding 40, Spacing 6
			let actvieWidth: CGFloat = activeTitleWidth + 60 + 6
			let removeCount: Int = isLastTabActive ? 1 : min(2, allTabs.count - 1)
			let spacingValue: CGFloat = CGFloat(allTabs.count - removeCount) * spacing
			let inActiveWidth: CGFloat =
				(containerSize.width - actvieWidth - spacingValue)
				/ CGFloat(allTabs.count - 1)
			HStack(spacing: spacing) {
				ForEach(allTabs, id: \.title) { Tab in
					TabItemView(Tab, inActiveWidth: inActiveWidth)
				}

			}
		}
		.padding(.trailing, isLastTabActive ? 0 : trailingVisibility)
		.frame(height: 38)
		.contentShape(.rect)
		.gesture(toggleGesture, isEnabled: isGestureEnabled)
		.animation(animation, value: selection)
		.onAppear {
			guard previousTab == nil else { return }
			previousTab = selection
		}
		.onChange(of: selection) { oldValue, newValue in
			previousTab = oldValue

		}
	}

	@ViewBuilder
	func TabItemView(_ tab: Tab, inActiveWidth: CGFloat) -> some View {
		let isActive = selection == tab
		HStack(spacing: isActive ? 6 : 0) {
			Image(systemName: tab.symbol)
				.font(.body)
				.frame(width: 20)
				.zIndex(1)
			Text(tab.title)
				.font(.callout)
				.fontWeight(.semibold)
				.fixedSize(horizontal: true, vertical: false)
				.lineLimit(1)
				.onGeometryChange(for: CGSize.self) {
					$0.size
				} action: { newValue in
					tabTitleSize[tab] = newValue
				}
				.frame(width: isActive ? nil : 0, alignment: .leading)
				.animation(animation.speed(isActive ? 1 : 2.5)) { content in
					content
						.opacity(isActive ? 1 : 0)
				}

		}
		.foregroundStyle(isActive ? tab.activeTint : .gray)
		.padding(.horizontal, isActive ? 20 : 0)
		.frame(maxHeight: .infinity)
		.frame(width: isActive ? nil : inActiveWidth)
		.background {
			ZStack {
				Capsule()
					.fill(.fill)
					.opacity(isActive ? 0 : 1)

				Capsule()
					.fill(tab.activeBackground)
					.opacity(isActive ? 1 : 0)
			}
		}
		.clipShape(.capsule)
		.contentShape(.capsule)
		.geometryGroup()
		.onTapGesture {

			if let lastTab = allTabs.last, let previousTab, selection == tab {
				if selection == lastTab {
					selection = previousTab
				} else {
					selection = lastTab
				}

			} else {
				selection = tab

			}
		}
	}

	var toggleGesture: some Gesture {
		DragGesture(minimumDistance: 20)
			.onEnded { value in
				let xTransition = value.translation.width
				guard abs(xTransition) > 40 else { return }
				if xTransition > 0 {
					guard let previousTab else { return }
					selection = previousTab
				} else {

				}

			}
	}

	var allTabs: [Tab.AllCases.Element] {
		Array(Tab.allCases.prefix(4))
	}

	var animation: Animation {
		.interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
	}
}
#Preview {
	ContentView()
}
