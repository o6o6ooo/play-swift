//
//  HorizontalCalendar.swift
//  HCalendarView
//
//  Created by Sakura Wallace on 08/07/2026.
//

import SwiftUI

struct Day: Identifiable {
	var id: String = UUID().uuidString
	var value: Int
	var weekdaySymbol: String
	var date: Date
	var notFromThisMonth: Bool = false
}

struct Week: Identifiable {
	var id: String = UUID().uuidString
	var days: [Day]

	static func load(from date: Date, value: Int) -> Self {
		var days: [Day] = []
		let calendar = Calendar.current
		let weekdaySymbols = calendar.shortWeekdaySymbols
		let modifiedWeekDate =
			calendar.date(byAdding: .weekOfMonth, value: value, to: date) ?? .now
		if let interval = calendar.dateInterval(
			of: .weekOfMonth,
			for: modifiedWeekDate
		) {
			let startOfWeek = interval.start
			for index in 0..<7 {
				if let date = calendar.date(
					byAdding: .day,
					value: index,
					to: startOfWeek
				) {
					let value = calendar.component(.day, from: date)
					let symbolIndex = calendar.component(.weekday, from: date) - 1
					let isCurrentMonth = calendar.isDate(
						date,
						equalTo: modifiedWeekDate,
						toGranularity: .month
					)
					days.append(
						.init(
							value: value,
							weekdaySymbol: weekdaySymbols[symbolIndex],
							date: date,
							notFromThisMonth: !isCurrentMonth
						)
					)
				}
			}
		}
		return .init(days: days)
	}
}

struct HorizontalCalendar<Content: View>: View {
	var updatesDateOnScroll: Bool
	@Binding var date: Date
	var content: (Day) -> Content
	init(
		updatesDateOnScroll: Bool = true,
		date: Binding<Date>,
		@ViewBuilder content: @escaping (Day) -> Content
	) {
		self.updatesDateOnScroll = updatesDateOnScroll
		self._date = date
		self.content = content
		let weeks: [Week] = (-1...1).compactMap {
			Week.load(from: date.wrappedValue, value: $0)
		}
		self.weeks = weeks
	}

	@State private var weeks: [Week]
	@State private var scrollPosition: ScrollPosition = .init()
	@State private var containerSize: CGSize = .zero
	@State private var islocked: Bool = false
	@State private var lockedID: String?
	@State private var weekIndex: Int = 1
	private let calendar = Calendar.current

	var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 0) {
				ForEach(weeks) { week in
					HStack(spacing: 0) {
						ForEach(week.days) { day in
							content(day)
								.frame(maxWidth: .infinity)
						}
					}
					.containerRelativeFrame(.horizontal)
					.visualEffect { [islocked, lockedID] content, proxy in
						let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
						return
							content
							.opacity(islocked ? (lockedID == week.id ? 1 : 0) : 1)
							.offset(x: islocked ? -minX : 0)
					}
				}
			}
		}
		.scrollIndicators(.hidden)
		.scrollTargetBehavior(.paging)
		.scrollPosition($scrollPosition)
		.defaultScrollAnchor(.center, for: .initialOffset)
		.onGeometryChange(for: CGSize.self) {
			$0.size
		} action: { newValue in
			containerSize = newValue
		}
		.onScrollGeometryChange(for: CGFloat.self) {
			$0.contentOffset.x + $0.contentInsets.leading
		} action: { oldValue, newValue in
			guard containerSize.width != .zero else { return }
			weekIndex = Int((newValue / containerSize.width).rounded())
			let addPreviousWeeks = newValue < 0
			let addNextWeeks = newValue > (containerSize.width * 2)

			if (addPreviousWeeks || addNextWeeks) && !islocked {
				guard let firstWeekDate = weeks.first?.days.first?.date else { return }
				guard let lastWeekDate = weeks.last?.days.first?.date else { return }

				let previousTwoWeeks: [Week] = [
					.load(from: lastWeekDate, value: -2),
					.load(from: lastWeekDate, value: -1),
				]

				let nextTwoWeeks: [Week] = [
					.load(from: firstWeekDate, value: 1),
					.load(from: firstWeekDate, value: 2),
				]

				if addPreviousWeeks {
					lockedID = weeks.first?.id
				} else {
					lockedID = weeks.last?.id
				}
				islocked = true
				if addPreviousWeeks {
					weeks.insert(contentsOf: previousTwoWeeks, at: 0)
					weeks.removeLast(2)
				} else {
					weeks.append(contentsOf: nextTwoWeeks)
					weeks.removeFirst(2)
				}

			} else {
				if islocked {
					var transaction = Transaction()
					transaction.scrollPositionUpdatePreservesVelocity = true
					withTransaction(transaction) {
						if addPreviousWeeks {
							scrollPosition.scrollTo(x: containerSize.width * 2)
						} else {
							scrollPosition.scrollTo(x: -containerSize.width * 2)
						}
					}

					islocked = false
					lockedID = nil
				}
			}
		}
		.onChange(of: weekIndex) { oldValue, newValue in
			if updatesDateOnScroll && weeks.indices.contains(newValue) {
				let symbolIndex = calendar.component(.weekday, from: date) - 1
				date = weeks[newValue].days[symbolIndex].date
			}
		}
	}
}

#Preview {
	ContentView()
}
