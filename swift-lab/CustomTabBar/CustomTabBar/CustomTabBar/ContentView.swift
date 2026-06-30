//
//  ContentView.swift
//  CustomTabBar
//
//  Created by Sakura Wallace on 30/06/2026.
//  Refer: https://youtu.be/UjR2FK6_DuQ?si=X1m70WTpididM9lD
//

import SwiftUI

enum AppTab {
	case home
	case saved
	case liked
	case account
}

struct ContentView: View {
	@State private var acctiveTab: AppTab? = .home
	@State private var isFABExpanded: Bool = false
	@State private var tabBar: UITabBar?
	var body: some View {
		TabView(selection: $acctiveTab) {
			Tab.init("Home", systemImage: "house", value: .home) {
				ScrollView(.vertical) {
					Rectangle()
						.foregroundStyle(.clear)
						.frame(height: 2000)
				}
				.tabOverlay(isPresented: isFABExpanded) {
					Text("FAB VIEW")
						.frame(maxWidth: .infinity)
						.frame(height: 220)
				} onDismiss: {
					isFABExpanded = false
				}
			}

			Tab.init("Saved", systemImage: "bookmark", value: .saved) {
				Text("Saved")
					.tabOverlay(isPresented: isFABExpanded) {
						Text("FAB VIEW")
							.frame(maxWidth: .infinity)
							.frame(height: 220)
					} onDismiss: {
						isFABExpanded = false
					}
			}

			Tab.init("Liked", systemImage: "suit.heart", value: .liked) {

			}

			Tab.init("Account", systemImage: "person", value: .account) {

			}

			Tab.init(value: .none, role: .search) {

			} label: {
				Image(systemName: "plus")
			}
		}
		.tabViewBottomAccessory {
			AccesoryView { oldValue, newValue in
				isFABExpanded = false
			}

		}
		.tabBarMinimizeBehavior(.onScrollDown)
		.onChange(of: acctiveTab) { oldValue, newValue in
			if newValue == nil {
				UITabBar.setAnimationsEnabled(false)
				acctiveTab = oldValue
				DispatchQueue.main.async {
					UITabBar.setAnimationsEnabled(true)
					isFABExpanded.toggle()
				}
			}

		}
		.background(TabBarExtractor { tabBar = $0 } )
		.compositingGroup()
		.onChange(of: isFABExpanded){ oldValue, newValue in
			animateFABIcon()
		}
	}
	private func animateFABIcon(){
		let fabImageViews = (tabBar?.subviews(type: UIImageView.self) ?? [])
			.filter({$0.description.contains("plus")})
		for fabImageView in fabImageViews {
			let trasform: CGAffineTransform = isFABExpanded ? .init(rotationAngle: 45 * .pi / 180) : .identity
			UIView.animate(withDuration: 0.2){
				fabImageView.layer.setAffineTransform(trasform)
			}

		}
	}
}

struct AccesoryView: View {
	var onPlacementChanged:
		(
			_ oldValue: TabViewBottomAccessoryPlacement?,
			_ newValue: TabViewBottomAccessoryPlacement?
		) -> Void
	@Environment(\.tabViewBottomAccessoryPlacement) private var placement
	var body: some View {
		Text("Accesory View")
			.onChange(of: placement) { oldValue, newValue in
				onPlacementChanged(oldValue, newValue)
			}
	}
}

extension View {
	@ViewBuilder
	func tabOverlay<Content: View>(
		isPresented: Bool,
		@ViewBuilder content: @escaping () -> Content,
		onDismiss: @escaping () -> Void
	) -> some View {
		self
			.modifier(
				TabOverlayModifier(
					isPresented: isPresented,
					viewContent: content,
					onDismiss: onDismiss
				)
			)
	}
}

struct TabOverlayModifier<ViewContent: View>: ViewModifier {
	var isPresented: Bool
	@ViewBuilder var viewContent: ViewContent
	var onDismiss: () -> Void
	@State private var isViewAppearing: Bool = false
	func body(content: Content) -> some View {
		content
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.overlay {
				if isViewAppearing {
					GlassEffectContainer {
						if isPresented {
							Rectangle()
								.fill(.black.opacity(0.25))
								.contentShape(.rect)
								.onTapGesture {
									onDismiss()
								}
								.ignoresSafeArea()
								.transition(.opacity)
						}
						if isPresented {
							viewContent
								.clipShape(.rect(cornerRadius: 30))
								.glassEffect(
									.regular.interactive(),
									in: .rect(cornerRadius: 30)
								)
								.frame(maxHeight: .infinity, alignment: .bottom)
								.padding(.horizontal, 15)
								.padding(.bottom, 10)
						}

					}
					.allowsHitTesting(isPresented)
					.animation(
						.interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0),
						value: isPresented
					)
				}
			}
			.onAppear {
				isViewAppearing = true
			}
			.onDisappear {
				isViewAppearing = false
			}
	}
}

struct TabBarExtractor: UIViewRepresentable {
	var resurt: (UITabBar) -> ()
	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		view.backgroundColor = .clear
		DispatchQueue.main.async {
			if let tbc = view.superview?.superview?.subviews.last?.subviews.first?
				.next as? UITabBarController
			{
				resurt(tbc.tabBar)
			}
		}
		return view
	}
	func updateUIView(_ uiView: UIViewType, context: Context) {

	}
}

fileprivate extension UIView{
	func subviews<T:UIView>(type: T.Type) -> [T]{
		subviews.compactMap{ $0 as? T } +
		subviews.flatMap{ $0.subviews(type: type)}
	}
}

#Preview {
	ContentView()
}
