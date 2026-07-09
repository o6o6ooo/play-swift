//
//  Toast.swift
//  GlassToasts
//
//  Created by Sakura Wallace on 09/07/2026.
//

import SwiftUI

struct ToastRootView<Content: View>: View {
	@ViewBuilder var content: Content
	@State private var activeToast: Toast?
	@State private var toastDismissWorkItem: DispatchWorkItem?
	var body: some View {
		content
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.overlay(alignment: .bottom) {
				GlassEffectContainer(spacing: 10) {
					if let activeToast {
						ToastView(activeToast)
					}
				}
				.opacity(activeToast == nil ? 0 : 1)
			}
			.environment(\.showToast) { toast in
				guard activeToast != nil else {
					withAnimation(animation) {
						activeToast = toast
					}
					scheduleDismiss(for: toast)
					return
				}

				withAnimation(
					animation.logicallyComplete(after: 0.17),
					completionCriteria: .logicallyComplete
				) {
					activeToast = nil
				} completion: {
					toastDismissWorkItem?.cancel()
					withAnimation(animation) {
						activeToast = toast
					}
					scheduleDismiss(for: toast)
				}
			}
			.environment(\.dismissToast){
				dismiss()
			}
	}
	@ViewBuilder
	private func ToastView(_ toast: Toast) -> some View {
		HStack(spacing: 10) {
			if let symbol = toast.symbol {
				Image(systemName: symbol)
					.font(.title3)
					.foregroundStyle(Color.primary)
					.transition(.identity)
			}
			Text(toast.title)
				.font(.body)
				.lineLimit(1)
			Spacer(minLength: 0)

			if let actionTitle = toast.actionTitle, let action = toast.action {
				Button {
					if action() {
						dismiss()
					}
				} label: {
					Text(actionTitle)
						.foregroundStyle(toast.actionTint)
				}
				.transition(.identity)
			}
		}
		.padding(.horizontal, 18)
		.frame(height: 50)
		.clipShape(.capsule)
		.contentShape(.capsule)
		.glassEffect(.regular, in: .capsule)
		.padding(.horizontal, 15)
		.offset(y: toast.placementOffset)
		.gesture(
			DragGesture()
				.onEnded{ value in
					let endTransition = value.translation.height
					if endTransition > 20{
						dismiss()
					}
				}
		)
		.transition(.offset(y: toast.transitionOffset))
	}
	private func dismiss() {
		withAnimation(animation) {
			activeToast = nil
		}
		toastDismissWorkItem?.cancel()
		toastDismissWorkItem = nil
	}
	private func scheduleDismiss(for toast: Toast) {
		toastDismissWorkItem?.cancel()
		let toastDismissWorkItem = DispatchWorkItem(block: dismiss)
		self.toastDismissWorkItem = toastDismissWorkItem
		let duration = TimeInterval(max(toast.duration, 1))
		DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: toastDismissWorkItem)
	}
	private let animation: Animation = .interpolatingSpring(
		duration: 0.35,
		bounce: 0.1,
		initialVelocity: 0
	)
}

struct Toast: Identifiable {
	private(set) var id: String = UUID().uuidString
	var title: String
	var duration: CGFloat
	var placementOffset: CGFloat
	var transitionOffset: CGFloat = 100
	var symbol: String? = nil
	var actionTitle: String? = nil
	var actionTint: Color = .accentColor
	var action: (() -> Bool)? = nil
}

extension EnvironmentValues {
	@Entry var showToast: (Toast) -> Void = { _ in }
	@Entry var dismissToast: () -> () = { }
}

#Preview {
	ContentView()
}
