//
//  ContentView.swift
//  HCalendarView
//
//  Created by Sakura Wallace on 08/07/2026.
//  Refer: https://www.youtube.com/watch?v=j0UnMCbzuEU
//

import SwiftUI

struct ContentView: View {
	@State private var selection: Date = .now
	private let calendar = Calendar.current
	var body: some View {
		VStack {
			HorizontalCalendar(date: $selection) { day in
				let isSelected = calendar.isDate(selection, inSameDayAs: day.date)
				VStack(spacing: 6) {
					Text(day.weekdaySymbol)
						.font(.caption)
						.foregroundStyle(.gray)
					Text("\(day.value)")
						.fontWeight(isSelected ? .semibold : .regular)
						.foregroundStyle(
							isSelected
								? .white : (day.notFromThisMonth ? Color.gray : Color.primary)
						)
						.frame(width: 38, height: 38)
						.background {
							if isSelected {
								Circle()
									.fill(.black)
							}
						}
						.contentShape(.rect)
						.onTapGesture {
							withAnimation(.snappy) {
								selection = day.date
							}
						}
				}
			}
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
