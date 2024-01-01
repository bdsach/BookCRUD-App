//
//  BookDetailView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct BookDetailView: View {
    var item: Book = Book(id: 0, name: "", author: "", price: 0)
    
    var body: some View {
        VStack(content: {
            Text(item.name)
                .font(.title).bold()
            Text(item.author)
                .font(.title2)
                .opacity(0.7)
            Text("Price: \(item.price)")
                .font(.headline)
                .opacity(0.9)
        })
    }
}

#Preview {
    BookDetailView()
}
