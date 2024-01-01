//
//  ContentView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BookListView()
                .tabItem {
                    Label("All Books", systemImage: "list.bullet.circle.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BookCRUDViewModel())
}
