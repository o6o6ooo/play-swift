//
//  ContentView.swift
//  MailTabBar
//
//  Created by Sakura Wallace on 29/06/2026.
//  Refer https://youtu.be/pM40Nv0LZrs?si=1jYyChF7oC4mMgqg
//

import SwiftUI

enum MailTab: MailTabItem{
	case primary
	case transactions
	case updates
	case promotions
	case allMails
	
	var title: String{
		return switch self{
		case .primary: "Primary"
		case .transactions: "Transactions"
		case .updates: "Updates"
		case .promotions: "Promotions"
		case .allMails: "All Mail"
		}
	}
	
	var symbol: String{
		return switch self{
		case .primary: "person.fill"
		case .transactions: "cart.fill"
		case .updates: "text.bubble.fill"
		case .promotions: "megaphone.fill"
		case .allMails: "tray.fill"
		}
	}
	
	var activeBackground: Color{
		return switch self{
		case .primary: .blue
		case .transactions: .green
		case .updates: .indigo
		case .promotions: .pink
		case .allMails: Color.white
		}
	}
	
	var acttveToint: Color{
		switch self{
		case .primary, .transactions, .updates, .promotions: .white
		case .allMails: Color.black
		}
	}
}

struct ContentView: View {
	@State private var activeTab: MailTab = .primary
    var body: some View {
			NavigationStack{
				ScrollView(.vertical){
					MailTabBar(
						spacing: 8,
						trailingVisibility: 15,
						isGestureEnabled: true,
						selection: $activeTab
					)
				}
				.safeAreaPadding(15)
				.navigationTitle("Inbox")
				}
		}
}

#Preview {
    ContentView()
}
