//
//  ListView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject private var vm: BookCRUDViewModel
    @State private var showAdd = false
    @State private var bookName: String = ""
    @State private var bookAuthor: String = ""
    @State private var bookPrice: String = ""
    @State private var submiting: Bool = false
    
    var body: some View {
        NavigationView(content: {
            if vm.isLoadingBooks {
                ProgressView()
                    .controlSize(.large)
            } else {
                List {
                    ForEach(vm.books) { item in
                        NavigationLink {
                            BookDetailView(item: item)
                        } label: {
                            Text(item.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            if let bookIndex = vm.books[index].id {
                                vm.deleteBook(withID: bookIndex)
                            }
                        }
                    })
                }
                .refreshable {
                    vm.allBook()
                }
                .navigationTitle("All Books")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "plus")
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                showAdd.toggle()
                            }
                            .sheet(isPresented: $showAdd, content: {
                                AddForm(bookName: $bookName, bookAuthor: $bookAuthor, bookPrice: $bookPrice, disableForm: $submiting) {
                                    submiting = true
                                    vm.addBook(bookName, bookAuthor,  Int(bookPrice) ?? 0) { result in
                                        switch result {
                                        case .success(let success):
                                            print("is ok", success)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                showAdd.toggle()
                                                vm.allBook()
                                                submiting = false
                                                bookName = ""
                                                bookAuthor = ""
                                                bookPrice = ""
                                            })
                                        case .failure(let failure):
                                            print("is fail", failure)
                                        }
                                    }
                                }
                            })
                    }
                }
            }
        })
    }
}

#Preview {
    BookListView()
        .environmentObject(BookCRUDViewModel())
}
