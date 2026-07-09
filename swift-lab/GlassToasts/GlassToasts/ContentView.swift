//
//  ContentView.swift
//  GlassToasts
//
//  Created by Sakura Wallace on 09/07/2026.
//  Refer: https://youtu.be/hR3qhzcrAE8?si=d5zVIy-RUzDH0gk8
//

import SwiftUI

struct ContentView: View {
	@State private var cartCount: Int = 0
	var body: some View {
		ToastRootView {
			TabView {
				Tab.init("For You", systemImage: "heart.text.square.fill") {
					ForYouView(cartCount: $cartCount)
				}
				Tab.init("Products", systemImage: "macbook.and.iphone") {

				}
				Tab.init("More", systemImage: "safari") {

				}
				Tab.init("Bag", systemImage: "bag") {

				}
					.badge(cartCount)
				Tab.init(role: .search) {

				}
			}
		}
	}
}

struct ForYouView: View {
	@Binding var cartCount: Int
	@Environment(\.showToast) private var showToast
	@Environment(\.dismissToast) private var dismissToast
	var body: some View {
		NavigationStack {
			List {
				Section("Demo") {
					HStack(spacing: 15) {
						Button("Add to Cart") {
							cartCount += 1
							showToast(.init(
									title: "Added to Cart!",
									duration: 3,
									placementOffset: -60,
									symbol: "cart.fill",
									actionTitle: "Undo",
									action: {
										cartCount -= 1
										showToast(undoCart())
										return false
									}
								)
							)
						}
						Button("Notify") {
							showToast(
								.init(title: "Notification Enabled", duration: 3, placementOffset: -60)
							)
						}
						Button("Dismiss"){
							dismissToast()
						}
					}
					.buttonStyle(.glass)
				}
			}
			.navigationTitle("Glass Toast's")
		}

	}
	private func undoCart() -> Toast{
		return .init(
			title: "Removed From Cart",
			duration: 3,
			placementOffset: -60,
			symbol: "checkmark.circle.fill"
		)
	}
}

#Preview {
	ContentView()
}
